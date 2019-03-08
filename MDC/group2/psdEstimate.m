addpath ..

%% estimate psd
file = load("analysisData.mat");
noiseVec = file.dataVec;
sampFreq = file.sampFreq; 
nSamples = length(noiseVec);
dataX = (0:(nSamples-1))/sampFreq; % timeVec

[pxx,f] = pwelch(noiseVec, 128,[],[],sampFreq);
psdPosFreq = transpose(pxx);
length(psdPosFreq)
figure;
plot(f,psdPosFreq);
xlabel('Frequency (Hz)');
ylabel('PSD');
% % Plot the colored noise realization
% figure;
% plot(dataX,noiseVec);
%%
% Search range of phase coefficients
rmin = [40, 1, 1];
rmax = [100, 50, 15];

% Number of independent PSO runs
nRuns = 16; % defalt 8
nIter = 4000; % number of iterations
%% 
file = load("analysisData.mat");
dataY = file.dataVec; %dataVec
Fs = file.sampFreq; 

%% run pso
% Input parameters for CRCBQCHRPPSO
inParams = struct('dataX', dataX,...
                  'dataY', dataY,...
                  'dataXSq',dataX.^2,...
                  'dataXCb',dataX.^3,...
                  'psd', psdPosFreq,...
                  'sampFreq', Fs,...
                  'rmin',rmin,...
                  'rmax',rmax);
             
outStruct = llrpso(inParams,struct('maxSteps',nIter),nRuns);
%%
% Plots
figure;
hold on;
plot(dataX,dataY,'.');
% plot(dataX,sig);
for lpruns = 1:nRuns
    plot(dataX,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',4.0);
end
plot(dataX,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);
% a1=55.1412; a2=47.3567; a3=8.7144                         
%% GLRT

% Phase coefficients parameters of the true signal
qcCoefs = outStruct.bestQcCoefs;
sigVec = crcbgenqcsig(dataX,1,qcCoefs);

normSigVec = normSig(sigVec, sampFreq, psdPosFreq, 1);

% GLRT
LG = innerprodpsd(dataY, normSigVec, sampFreq, psdPosFreq)^2;
% LG = 1.7776e+03

% MLE
MLE = outStruct.bestFitness;
% MLE = -1.7776e+03
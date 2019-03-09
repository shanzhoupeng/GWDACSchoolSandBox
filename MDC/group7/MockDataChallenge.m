%% Mock Data Challenge
%Including GLRT and MLE.
addpath ../
addpath ../../PSO/group7/
addpath ../../NOISE/

load('TrainingData.mat')
load('analysisData.mat')

% Data length
nSamples = length(dataVec);
% Sampling frequency
%Fs = sampFreq;

% Search range of phase coefficients
rmin = [40, 1, 1];
rmax = [100, 50, 15];

% Number of independent PSO runs
nRuns = 2;
% Number of iterations in PSO for one run
maxSteps=1000;

%% Noise parameters
% PSD function
% Training 
[pxx,f] = pwelch(trainData,256,[],[],sampFreq);%single-sided psd
pxx=pxx/2;
%% Do not change below
% Generate data realization
dataX = (0:(nSamples-1))/sampFreq;
% Reset random number generator to generate the same noise realization,
% otherwise comment this line out
% rng('default');
% Generate data realization

% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

psdPosFreq = interp1(f,pxx,posFreq);
 
% Input parameters for CRCBQCHRPPSO
inParams = struct('dataX', dataX,...
                  'dataY', dataVec,...
                  'dataXSq',dataX.^2,...
                  'dataXCb',dataX.^3,...
                  'psd',psdPosFreq,...
                  'sampFreq',sampFreq,...
                  'rmin',rmin,...
                  'rmax',rmax);              
% CRCBQCHRPPSO runs PSO on the CRCBQCHRPFITFUNC fitness function. As an
% illustration of usage, we change one of the PSO parameters from its
% default value.
outStruct = qcpso(inParams,struct('maxSteps',maxSteps),nRuns);

%%
% Plots
figure;
hold on;
plot(dataX,dataVec,'.');
% plot(dataX,sigVec);
for lpruns = 1:nRuns
    plot(dataX,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',2.0);
end
plot(dataX,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',1.0);
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);



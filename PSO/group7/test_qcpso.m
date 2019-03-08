%% Generate simulated data & Minimize the fitness function QCFITFUNC using PSO
% Data length
nSamples = 512;
% Sampling frequency
Fs = 512;
% Signal to noise ratio of the true signal
snr = 10;

%% Signal parameters
% Phase coefficients parameters of the true signal
a1 = 10;
a2 = 3;
a3 = 3;

% Search range of phase coefficients
rmin = [1, 1, 1];
rmax = [180, 10, 10];

% Number of independent PSO runs
nRuns = 8;

%% Noise parameters
% PSD function
noisePSD = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625 + 1;

%order needed in "statgaussnoisegen" function which generate a realization 
%of stationary Gaussian noise with given PSD
fltrOrdr=100;

%% Do not change below
% Generate data realization
dataX = (0:(nSamples-1))/Fs;
% Reset random number generator to generate the same noise realization,
% otherwise comment this line out
%rng('default');
% Generate data realization

% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/Fs;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%Get normalized signal
sigVec = crcbgenqcsig(dataX,snr,[a1,a2,a3]);
sigVec = normsig4psd(sigVec,Fs,psdPosFreq,snr);
%Generate noise realization

noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],fltrOrdr,Fs);

%Data
dataY = noiseVec+sigVec;

% Input parameters for CRCBQCHRPPSO
inParams = struct('dataX', dataX,...
                  'dataY', dataY,...
                  'dataXSq',dataX.^2,...
                  'dataXCb',dataX.^3,...
                  'psd',psdPosFreq,...
                  'sampFreq',Fs,...
                  'rmin',rmin,...
                  'rmax',rmax);              
% CRCBQCHRPPSO runs PSO on the CRCBQCHRPFITFUNC fitness function. As an
% illustration of usage, we change one of the PSO parameters from its
% default value.
outStruct = qcpso(inParams,struct('maxSteps',1000),nRuns);

%%
% Plots
figure;
hold on;
plot(dataX,dataY,'.');
plot(dataX,sigVec);
for lpruns = 1:nRuns
    plot(dataX,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',4.0);
end
plot(dataX,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);






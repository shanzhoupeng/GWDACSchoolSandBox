%% Mock Data Challenge

% Yu Sang, Mar 8th 2019

addpath ../

TrainingData = load('TrainingData.mat');
analysisData = load('analysisData.mat');

%% Data
dataY = analysisData.dataVec;
% Data length
nSamples = length(dataY);
% Sampling frequency
Fs = analysisData.sampFreq;
% Generate time vector
dataX = (0:(nSamples-1))/Fs;
%% Noise only
noiseVec = TrainingData.trainData;
% noise length
nSamples_noise = length(noiseVec);

%% Search range of phase coefficients
rmin = [40, 1, 1];
rmax = [100, 50, 15];

% Number of independent PSO runs
nRuns = 8;

%% PSD
% Generate the PSD vector to be used. Should be
% generated for all positive DFT frequencies. 
[psdPosFreq,posFreq]=pwelch(noiseVec, 256,[],[],Fs);

dataLen = nSamples/Fs;
kNyq = floor(nSamples/2)+1;
posFreq_regular = (0:(kNyq-1))*(1/dataLen);
% interpolating the modified PSD to a regular grid of frequency values
psdPosFreq_regular = interp1(posFreq, psdPosFreq, posFreq_regular);
% % plot PSD
% figure;
% plot(posFreq_regular,psdPosFreq_regular);

% Input parameters for CRCBQCHRPPSO
inParams = struct('dataX', dataX,...
                  'dataY', dataY,...
                  'dataXSq',dataX.^2,...
                  'dataXCb',dataX.^3,...
                  'rmin',rmin,...
                  'rmax',rmax,...
                  'psd', psdPosFreq_regular,...
                  'sampFreq',Fs);
% CRCBQCHRPPSO runs PSO on the CRCBQCHRPFITFUNC fitness function. As an
% illustration of usage, we change one of the PSO parameters from its
% default value.
outStruct = CGNqcpso(inParams,struct('maxSteps',2000),nRuns);

%%
% Plots
figure;
hold on;
plot(dataX,dataY,'.');
%plot(dataX,sig);
for lpruns = 1:nRuns
    plot(dataX,outStruct.allRunsOutput(lpruns).estSig,'Color',[51,255,153]/255,'LineWidth',4.0);
end
plot(dataX,outStruct.bestSig,'Color',[76,153,0]/255,'LineWidth',2.0);
disp(['Estimated parameters: a1=',num2str(outStruct.bestQcCoefs(1)),...
                             '; a2=',num2str(outStruct.bestQcCoefs(2)),...
                             '; a3=',num2str(outStruct.bestQcCoefs(3))]);
disp(['best fitness value  ', num2str(outStruct.bestFitness)]);                         
                         
%% test significance and estimate SNR
% Generate the signal that is to be normalized
a1 = outStruct.bestQcCoefs(1);
a2 = outStruct.bestQcCoefs(2);
a3 = outStruct.bestQcCoefs(3);
% Amplitude value does not matter as it will be changed in the normalization
%A = 1; 
%sigVec = crcbgenqcsig(dataX,1,[a1,a2,a3]);          
% % GLR from the data, GLR observed
% GLRobs = calGLRqc(dataY,nSamples,Fs,psdPosFreq_regular, [a1,a2,a3]);
% GLR observed is the minus of best fitness value 
GLRobs = - outStruct.bestFitness;

% estimate the significance of the GLRT values
nH0Data = 1000;
glrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq_regular(:),psdPosFreq_regular(:)],100,Fs);
    glrH0(lp) = calGLRqc(noiseVec,nSamples,Fs,psdPosFreq_regular,[a1,a2,a3]);
end

% significance of the GLRT values for the 3 data realizations
significance =  sum( glrH0 > GLRobs ) / nH0Data;

%% estimate SNR
% Signal to noise ratio estimate
estSNR = (GLRobs - mean(glrH0))/std(glrH0);



% a1=50.142; a2=29.803; a3=10.0597

% answer given by Prof.
% a1 = 50, a2 = 30, a3 = 10, SNR = 8.3
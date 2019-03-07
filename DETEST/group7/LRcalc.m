%% Calculate LR for Quadratic chirp signal
% We will calculate the Likelihood ratio (LR) after maximization over
% amplitude for a quadratic chirp in noise with a given Power Spectral
% Density (PSD).

%%
% We will reuse codes that have already been written.
% Path to folder containing signal and noise generation codes.
addpath ../../DSP
addpath ../../NOISE/


%% Parameters for data realization
% Number of samples and sampling frequency.
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;

%% Supply PSD values
% This is the noise psd we will use.
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%% Generate  data realization
% Noise + SNR=10 signal. *Note*: The signal in the data realization has parameters
% that are different from the ones at which the LR is evaluated below.
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
sig4data = crcbgenqcsig(timeVec,1,[9.5,2.8,3.2]);
% Signal normalized to SNR=10
[sig4data,~]=normsig4psd(sig4data,sampFreq,psdPosFreq,10);
dataVec = noiseVec+sig4data;
figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sig4data,'r');
xlabel('Time (sec)')
ylabel('Data');
title('Data realization for calculation of LR');



%% Template for LR
% We will obtain the LR (after amplitude maximization) for the given data
% realization at the following parameter values.
a1=10;
a2=3;
a3=3;
A = 1; 
%%
% Generate the template vector for the above parameters.
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);
%We do not need the normalization factor, just the signal normalized to
%have snr=1 (i.e., the template vector)
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,1);

%% Calculate LR
llr = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq);
llr = llr^2;
disp(llr);


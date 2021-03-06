%%
% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);
sampFreq = 1024;

% This is the target SNR
snr = 10;
nSamples = length(sigVec);

dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);


%%
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 



% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. (Exercise: Prove that if the noise PSD
% is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
psdPosFreq = noisePSD(posFreq);

[sigVec, estSNR] = SNRCalc(sigVec, sampFreq, psdPosFreq, snr);

estSNR



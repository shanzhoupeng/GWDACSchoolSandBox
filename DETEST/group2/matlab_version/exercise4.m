% Exercise 4

%Zu-Cheng Chen, Mar 2019

files = ["data1.mat", "data2.mat", "data3.mat"];
% 
significances = [];
for i = 1:3
load(files(i))
%% Data generation parameters

nSamples = length(dataVec);
timeVec = (0:(nSamples-1))/sampFreq;

%% signal
% Generate the signal that is to be normalized
a1 = 10;
a2 = 3;
a3 = 3;
snr = 1;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec, snr, [a1,a2,a3]);
[sigVec, normFactor] = normSig(sigVec, sampFreq, psdPosFreq, snr);

%%
% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m

% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. 
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

fltrOrdr = 30;
psdVals = [posFreq(:),psdPosFreq(:)];

LG = GLRT(dataVec,sigVec,sampFreq,psdPosFreq);
%% 

nData = 10000;
llrs = zeros(1,nData);
for lp = 1:nData
    noiseVec = statgaussnoisegen(nSamples,psdVals,fltrOrdr,sampFreq);
    llrs(lp) = GLRT(noiseVec,sigVec,sampFreq,psdPosFreq);
end

significances(i) = sum(llrs > LG)/nData;
end

significances
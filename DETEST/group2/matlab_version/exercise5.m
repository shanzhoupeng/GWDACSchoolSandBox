% Exercise 5

%Zu-Cheng Chen, Mar 2019

addpath ../..
files = ["data1.mat", "data2.mat", "data3.mat"];
% 
significances = [];
for i = 1:3
file = load(files(i));
dataVec = file.dataVec;
sampFreq = file.sampFreq;
nSamples = length(dataVec);

%% signal
% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
qcCoefs = [a1,a2,a3];

%%
% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m

% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. 
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

fltrOrdr = 100;
psdVals = [posFreq(:),psdPosFreq(:)];

LG = fitFunc(dataVec,qcCoefs,sampFreq,psdPosFreq);
%% 

nData = 10000;
llrs = zeros(1,nData);
for lp = 1:nData
    noiseVec = statgaussnoisegen(nSamples,psdVals,fltrOrdr,sampFreq);
    llrs(lp) = fitFunc(noiseVec,qcCoefs,sampFreq,psdPosFreq);
end

significances(i) = sum(llrs > LG)/nData;
end

significances
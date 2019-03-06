addpath functions
% Load three data vectors and sample frequency
data1 = load('data/data1.mat');
data2 = load('data/data2.mat');
data3 = load('data/data3.mat');
dataVec1 = data1.dataVec;
dataVec2 = data2.dataVec;
dataVec3 = data3.dataVec;

% Data generation parameters
nSamples = length(dataVec1);
sampFreq = data1.sampFreq;
timeVec = (0:(nSamples-1))/sampFreq;

% Generate the signal that is to be normalized
a1 = 10;
a2 = 3;
a3 = 3;
A = 10; 
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);

% Normalize signal to specified SNR
SNR = 1;
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
[norsigVec,norfac] = NorSig(sigVec,sampFreq,noisePSD,SNR);

% Get GLRT values of three data vectors
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);
LG1 = GLRT(dataVec1,norsigVec,sampFreq,psdPosFreq);
LG2 = GLRT(dataVec2,norsigVec,sampFreq,psdPosFreq);
LG3 = GLRT(dataVec3,norsigVec,sampFreq,psdPosFreq);

% Generate 3000 data realizations and compute their GLRT values
nH0Data = 3000;
llrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llrH0(lp) = GLRT(noiseVec,norsigVec,sampFreq,psdPosFreq);
end

% Use a large number of trial values of GLRT to estimate significance
sigcn1 = length(llrH0(llrH0>=LG1))/nH0Data;
sigcn2 = length(llrH0(llrH0>=LG2))/nH0Data;
sigcn3 = length(llrH0(llrH0>=LG3))/nH0Data;
sigcn = [sigcn1;sigcn2;sigcn3;nH0Data];
% Output significances and number of trials
csvwrite('Team4_testSig.txt',sigcn);

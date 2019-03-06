%% Exercise #4: Part 2

% Yu Sang, Mar 5th 2019

addpath ../

%% data Vector
data1 = load('data1.mat');
dataVec1 = data1.dataVec;
sampFreq1 = data1.sampFreq;

data2 = load('data2.mat');
dataVec2 = data2.dataVec;
sampFreq2 = data2.sampFreq;

data3 = load('data3.mat');
dataVec3 = data3.dataVec;
sampFreq3 = data3.sampFreq;

%% parameters
sampFreq = sampFreq1;

nSamples = length(dataVec1);
timeVec = (0:(nSamples-1))/sampFreq;

%% Generate the signal 
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);

%%
% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. (Exercise: Prove that if the noise PSD
% is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);
% figure;
% plot(posFreq,psdPosFreq);
% axis([0,posFreq(end),0,max(psdPosFreq)]);
% xlabel('Frequency (Hz)');
% ylabel('PSD ((data unit)^2/Hz)');

%% calculate the GLRT for this signal
GLR1 = calGLR(dataVec1,sigVec,sampFreq,psdPosFreq)
GLR2 = calGLR(dataVec2,sigVec,sampFreq,psdPosFreq)
GLR3 = calGLR(dataVec3,sigVec,sampFreq,psdPosFreq)


%% estimate the significance of the GLRT values
nH0Data = 10000;
glrH0 = zeros(1,nH0Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    glrH0(lp) = calGLR(noiseVec,sigVec,sampFreq,psdPosFreq);
end

% significance of the GLRT values for the 3 data realizations
signif1 =  sum( glrH0 > GLR1 ) / nH0Data
signif2 =  sum( glrH0 > GLR2 ) / nH0Data
signif3 =  sum( glrH0 > GLR3 ) / nH0Data
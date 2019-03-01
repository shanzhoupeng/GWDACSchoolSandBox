%% Simulating LIGO noise
% Load data of initial LIGO design sensitivity
y = load('iLIGOSensitivity.txt','-ascii');
% Length of the data
L = length(y);
% For f<= 50Hz, S_n(f)=S_n(f=50)
y(1:41,2) = y(42,2);
% For f>= 700Hz, S_n(f)=S_n(f=700)
y(71:L,2) = y(70,2);
%Sampling frequency for noise realization
sampFreq = 4096;
%Number of samples to generate
nSamples = 16384;
%Time samples
timeVec = (0:(nSamples-1))/sampFreq;
% Filter order
fltrOrdr = 500;
% Generate a WGN realization and pass it through the designed filter
outNoise = colgen(nSamples,y,fltrOrdr,sampFreq);
% Plot the colored noise realization
figure;
plot(timeVec,outNoise);
% Estimate the PSD
figure;
pwelch(outNoise, 512,[],[],sampFreq);
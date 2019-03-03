% A test for group1
%% Spectrogram demo
% Signal parameters
t0=0.5;
sigma=1;
f0=5;
phi0=0;
A = 10;

%
sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;% so timeVec is 2 sec.


%%
% Generate signal
sigVec = sgsig(timeVec,A,[t0,sigma,f0,phi0]);

%% 
% Make periodogram 
figure;
periodogram(sigVec, [],[],sampFreq);


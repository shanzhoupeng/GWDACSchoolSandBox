clear
clc

sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;
%% generate a Quadratic Chirp signal for time-frequency analysis

% Signal parameters
a1=10;
a2=3;
a3=10;
A = 10;
% Generate signal
sigVec = crcbgenqcsig(timeVec,A,[a1,a2,a3]);
% plot(sigVec);
figure(1)
spectrogram(sigVec,kaiser(128,18),120,256,1024,'yaxis');

% figure(2)
% [S,F,T] = spectrogram(sigVec,kaiser(128,18),120,256,1024);
% imagesc(T,F,abs(S));
% axis X Y;

%% generate a AM-FM sinusoid signal for time-frequency analysis

% Signal parameters
dataT = timeVec;
f0=10;
f1=20;
snr = 10;
b = 5;
% Generate signal
sigVec2 = genamfmsinsig(dataT,snr,b,f0,f1)
% plot(sigVec2);
figure(2)
spectrogram(sigVec2,kaiser(128,18),120,256,1024,'yaxis');



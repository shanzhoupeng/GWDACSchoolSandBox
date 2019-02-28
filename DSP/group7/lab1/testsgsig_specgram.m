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
% Make spectrogram with different time-frequency resolution

figure;
spectrogram(sigVec, 128,127,[],sampFreq);
figure;
spectrogram(sigVec, 256,250,[],sampFreq);

%%
% Make plots independently of the spectrogram function
[S,F,T]=spectrogram(sigVec, 256,250,[],sampFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

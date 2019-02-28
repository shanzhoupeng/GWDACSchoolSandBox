%% Spectrogram demo
sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;% so timeVec is 2 sec.


%% Sinusoid signal
f0=10;
phi0=3;
A = 10;

%%
% Generate signal
sigVec = gensinsig(timeVec,A,f0,phi0);

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



%% Spectrogram 
% Signal parameters
a1=5;
a2=3;
A = 10;
Phi0 =5;

%
sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;% so timeVec is 2 sec.


%%
% Generate signal
sigVec = genlcsig(timeVec,A,[a1,a2],Phi0);

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

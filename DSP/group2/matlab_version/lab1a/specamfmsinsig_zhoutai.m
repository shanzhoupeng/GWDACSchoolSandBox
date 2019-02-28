%% Spectrogram
sampleNum = 2048;
sampleFre = 1024;
timeVec = (0:sampleNum-1)/sampleFre;

%% Generate AM-FM signal
sigVec = genamfmsinsig(timeVec,10,30,50,10);
fftSig = fft(sigVec);
fftSig = fftSig(1:sampleNum/2);

%% FFT & Spectrogram
figure;
plot((0:sampleNum/2-1)/2,abs(fftSig));
figure;
spectrogram(sigVec, 128,127,[],sampleFre);
figure;
spectrogram(sigVec, 256,250,[],sampleFre);

%%
% Make plots independently of the spectrogram function
[S,F,T] = spectrogram(sigVec, 256,250,[],sampleFre);
figure;
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

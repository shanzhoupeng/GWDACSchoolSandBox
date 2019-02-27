
%% Plot the AM signal
timeVec = 0:1/3000:5/10;
A=10;
f0=400;
f1=100;
f2=250;
phi=70/5;
dataLen = timeVec(end)-timeVec(1);%Length of data 
nSamples = length(timeVec);% Number of samples
sigVec = AM(A,[f0,f1],phi,timeVec)+AM(A,[f0,f2],phi,timeVec);
plot(timeVec,sigVec)
%% fft anlysis
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);
%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
%% Make spectrogram with different time-frequency resolution
figure;
spectrogram(sigVec, 128,127,[],300);
figure;
spectrogram(sigVec, 256,250,[],300);

%%
% Make plots independently of the spectrogram function
[S,F,T]=spectrogram(sigVec, 256,250,[],300);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

%% Design low pass filter for signal
maxFreq=40;
sampFreq=1024;
filtOrdr1=50;
b= fir1(filtOrdr1,(maxFreq/2)/(sampFreq/2),'low');
filtSig1 = fftfilt(b,sigVec);
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig1);

%% Design band pass filter for signal
maxFreq1=100;
maxFreq2=200;
sampFreq=1024;
filtOrdr1 = 30;
b1 = fir1(filtOrdr1,[(maxFreq1/2)/(sampFreq/2),(maxFreq2/2)/(sampFreq/2)],'bandpass');
filtSig1 = fftfilt(b1,sigVec);
figure(1);
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig1);

%% Design high pass filter for signal
maxFreq=200;
sampFreq=1024;
filtOrdr1 = 30;
b1 = fir1(filtOrdr1,[(maxFreq/2)/(sampFreq/2)],'high');
filtSig1 = fftfilt(b1,sigVec);
figure(1);
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig1);
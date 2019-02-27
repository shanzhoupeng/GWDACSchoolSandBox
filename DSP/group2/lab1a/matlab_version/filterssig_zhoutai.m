%% Basic
sampleNum=2048;
sampleFre=1024;
timeVec=(0:sampleNum-1)/sampleFre;

%% Generate 3 signals
sigVec1=genssig(timeVec,[10,100,0]);
sigVec2=genssig(timeVec,[5,200,pi/6]);
sigVec3=genssig(timeVec,[2.5,300,pi/4]);
sigSum=sigVec1+sigVec2+sigVec3;

%% Generate Filters
filtOrder=30;
fil1=fir1(filtOrder,150*2/sampleFre,"low");
fil2=fir1(filtOrder,[150*2/sampleFre,250*2/sampleFre],"bandpass");
fil3=fir1(filtOrder,250*2/sampleFre,"high");
sigFil1=fftfilt(fil1,sigSum);
sigFil2=fftfilt(fil2,sigSum);
sigFil3=fftfilt(fil3,sigSum);

%% Generate FFT
fftSigSum=fft(sigSum);
fftSigSum=fftSigSum(1:sampleNum/2);
fftSigFil1=fft(sigFil1);
fftSigFil1=fftSigFil1(1:sampleNum/2);
fftSigFil2=fft(sigFil2);
fftSigFil2=fftSigFil2(1:sampleNum/2);
fftSigFil3=fft(sigFil3);
fftSigFil3=fftSigFil3(1:sampleNum/2);
posFreq=(0:sampleNum/2-1)/2;

%% Signal
figure;
hold on;
plot(timeVec,sigSum);
plot(timeVec,sigFil1);
plot(timeVec,sigFil2);
plot(timeVec,sigFil3);
xlabel('Frequency (Hz)');
legend("Sum of Signals","Filter 1","Filter 2","Filter 3");

%% FFT
figure;
plot(posFreq,abs(fftSigSum));
figure;
hold on;
plot(posFreq,abs(fftSigFil1));
plot(posFreq,abs(fftSigFil2));
plot(posFreq,abs(fftSigFil3));
xlabel('Frequency (Hz)');
legend("Filter 1","Filter 2","Filter 3");

%% Specgram
figure;
subplot(141);
[S,F,T]=spectrogram(sigSum, 256,250,[],sampleFre);
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title("Sum of Signals");
subplot(142);
[S,F,T]=spectrogram(sigFil1, 256,250,[],sampleFre);
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
title("Filter 1");
subplot(143);
[S,F,T]=spectrogram(sigFil2, 256,250,[],sampleFre);
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
title("Filter 2");
subplot(144);
[S,F,T]=spectrogram(sigFil3, 256,250,[],sampleFre);
imagesc(T,F,abs(S));
axis xy;
xlabel('Time (sec)');
title("Filter 3");

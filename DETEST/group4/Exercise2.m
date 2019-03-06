%% Exercise2
% In this exercise we generate the LIGO noise with a signal in it.
% Xue Xiao, Group4
nSamples = 16384;
sampFreq = 2048;
Time = nSamples/sampFreq;
timeVec = (0:nSamples-1)/sampFreq;
kNyq = floor(nSamples/2)+1;
postFreq = (1:(kNyq-1))/Time;

load('data/iLIGOss.mat')
freqVec = iLIGOss(:,1);
targetVec = iLIGOss(:,2);

filt = fir2(100,freqVec/(sampFreq/2),targetVec);

innoise  = randn(1,nSamples);
outnoise = sqrt(sampFreq)*fftfilt(filt,innoise);

% in this pic we check the psd of the outnoise
subplot(2,2,1)
pwelch(outnoise, 256,[],[],sampFreq);

sig0 = crcbgenfmsig(timeVec,norm(outnoise)*0.5,[300,200,2,3]);
sig  = outnoise+sig0;

% in this pic we compare the real signal with the sig+noise
subplot(2,2,2)
plot(timeVec,sig)
hold on
plot(timeVec,sig0)
xlabel('Time (sec)');

% in this pic we draw the time-frequency spectrograms
[S,F,T] = spectrogram(sig, 64,63,[],sampFreq);
subplot(2,2,3)
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('Time-Frequency domain spectrogram')

% show the signal at the frequency domain
fft0 = fft(sig0); fft0=fft0(1:kNyq);
fft1 = fft(sig) ; fft1=fft1(1:kNyq);
freqVec=(0:kNyq-1)/Time;
subplot(2,2,4)
plot(freqVec,abs(fft1))
hold on 
plot(freqVec,abs(fft0))
xlabel('Frequency (Hz)');


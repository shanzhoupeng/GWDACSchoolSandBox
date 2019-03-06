%% Exercise2
% In this exercise we generate the LIGO noise with a signal in it.
% Xue Xiao, Group4, Mar 2019
addpath functions

%% Input the LIGO sensitivity
nSamples = 4096;
sampFreq = 2048;
Time = nSamples/sampFreq;
timeVec = (0:nSamples-1)/sampFreq;
kNyq = floor(nSamples/2)+1;

load('data/iLIGOss.mat')
freqVec = iLIGOss(:,1);
targetVec = iLIGOss(:,2).^2; %fixed: .^2 

%% Filtering the noise
outnoise = statgaussnoisegen(nSamples,[freqVec(:),targetVec(:)],100,sampFreq);

% in this pic we check the psd of the outnoise
subplot(2,2,1)
pwelch(outnoise, 256,[],[],sampFreq);

%% Put signal into the noise and plot
sig0 = crcbgenfmsig(timeVec,norm(outnoise)*3,[300,200,2,3]);
data  = outnoise+sig0;

% in this pic we compare the real signal with the sig+noise
subplot(2,2,2)
plot(timeVec,data)
hold on
plot(timeVec,sig0)
xlabel('Time (sec)');

%% Draw spectrogram of the noise+signal
% in this pic we draw the time-frequency spectrograms
[S,F,T] = spectrogram(data, 64,63,[],sampFreq);
subplot(2,2,3)
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
title('Time-Frequency domain spectrogram')

% show the signal at the frequency domain
fft0 = fft(sig0); fft0=fft0(1:kNyq);
fft1 = fft(data) ; fft1=fft1(1:kNyq);
freqVec=(0:(kNyq-1))/Time;
subplot(2,2,4)
plot(freqVec,abs(fft1))
hold on 
plot(freqVec,abs(fft0))
xlabel('Frequency (Hz)');

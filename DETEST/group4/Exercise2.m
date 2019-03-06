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
ifreqVec = iLIGOss(:,1);
ipsdVec = iLIGOss(:,2).^2; %fixed: .^2 

% Interpolate

freqVec = (0:(kNyq-1))/Time;
psdVec  = interp1(ifreqVec, ipsdVec, freqVec);

%% Filtering the noise
outnoise = statgaussnoisegen(nSamples,[freqVec(:),psdVec(:)],100,sampFreq);

% in this pic we check the psd of the outnoise
subplot(2,2,1)
pwelch(outnoise, 128,[],[],sampFreq);

%% Normalize the signal & Put signal into the noise and plot
sig0 = crcbgenfmsig(timeVec,1,[300,200,1,3]);
%sig0 = crcbgenqcsig(timeVec,1,[100,30,3]);
normfactor = innerprod(sig0, sig0, sampFreq, psdVec);
sigVec = 10*sig0/sqrt(normfactor);
data  = outnoise+sigVec;


% in this pic we compare the real signal with the sig+noise
subplot(2,2,2)
plot(timeVec,data)
hold on
plot(timeVec,sigVec)
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
fft0 = fft(sigVec); fft0=fft0(1:kNyq);
fft1 = fft(data) ; fft1=fft1(1:kNyq);

subplot(2,2,4)
plot(freqVec,abs(fft1))
hold on 
plot(freqVec,abs(fft0))
xlabel('Frequency (Hz)');

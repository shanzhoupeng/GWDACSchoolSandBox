%% Plot the Amplitude modulated(AM) sinusoid
%S(t)=A*cos(2*pi*f0.*t).*sin(f1.*t+phi)
% Signal parameters
A=10;
f0=2;
f1=5/3;
phi=7/5;

% Time samples
% Group4: Redo the sampling
sampFreq = 8;
nSamples = 256;
timeVec = (0:(nSamples-1))/sampFreq;

% Generate the signal
sigVec =Am(A,[f0,f1],phi,timeVec);

%Plot the signal 
figure;
plot(timeVec,sigVec)

%% fft
dataLen = timeVec(end)-timeVec(1);
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));

%% Make Spectrogram
figure;
spectrogram(sigVec, 128,125,[],sampFreq);
figure;
spectrogram(sigVec, 64,62,[],sampFreq);

% Make plots independently of the spectrogram function
[S,F,T]=spectrogram(sigVec, 64,62,[],sampFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

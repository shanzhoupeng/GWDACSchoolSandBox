%% Plot the Amplitude modulated(AM) sinusoid
%S(t)=A*cos(2*pi*f0.*t).*sin(f1.*t+phi)
% Signal parameters
A=10;
f0=2;
f1=5/3;
phi=7/5;

% Time samples
timeVec = 0:1/50:5.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec =AM(A,[f0,f1],phi,timeVec);

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

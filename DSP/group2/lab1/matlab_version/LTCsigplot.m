%% Plot the linear transient chirp signal
% Signal parameters
snr = 10;
ta = 0.5;
f0 = 20;
f1 = 20;
phi0 = pi;
L = 0.5;

% Instantaneous frequency after 1 sec is 
maxFreq = 2*pi*(f0*(1-ta) + f1*(1-ta)^2) + phi0;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = LTCsig(timeVec,snr,ta,f0,f1,phi0,L);

%Plot the signal 
figure;
plot(timeVec,sigVec)

%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
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

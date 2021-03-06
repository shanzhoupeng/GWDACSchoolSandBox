%% Plot the Sine-Gaussian signal
% Signal parameters
t0=0.5;
sigma=1;
f0=5;
phi0=0;
A = 10;
% Instantaneous frequency after 1 sec is 
maxFreq = f0;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;
 
% Time samples
timeVec = 0:samplIntrvl:10;
% Number of samples
nSamples = length(timeVec);
 
% Generate the signal
sigVec = sgsig(timeVec,A,[t0,sigma,f0,phi0]);
 
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
 
%Plot spectrogram (by Shucheng Yang of group1) 
spectrogram(sigVec,30,[],[],samplFreq)

%% Plot the Frequency modulated (FM) sinusoid signal
% Signal parameters
f0 = 10 ;
f1 = 10 ;
b = 2 ;
A = 10;
% Instantaneous frequency after 1 sec is 
maxFreq =  f0 + 1/(2*pi) * b * 2 * pi * f1 ;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = crcbgenfmsig(timeVec,A,[f0,f1,b/(2*pi)]);

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

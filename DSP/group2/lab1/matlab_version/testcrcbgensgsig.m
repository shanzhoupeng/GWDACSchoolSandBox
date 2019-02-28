%% Plot the sine-gaussian signal
% Signal parameters
a1=10;
a2=3;
a3=3;
a4=2;
A = 10;
% Instantaneous frequency after 1 sec is 
Freq = a3;
samplFreq = 5*Freq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:10;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = crcbgensgsig(timeVec,A,[a1,a2,a3,a4]);

% Plot the signal 
figure;
plot(timeVec,sigVec)

% Plot the periodogram
%--------------
% Length of data 
dataLen = timeVec(end)-timeVec(1);
% DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

% Plot periodogram
figure;
plot(posFreq,abs(fftSig));

%Plot spectrogram (by Shucheng Yang of group1) 
spectrogram(sigVec,20,19,[],samplFreq)


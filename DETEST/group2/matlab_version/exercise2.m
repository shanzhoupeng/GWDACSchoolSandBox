% Exercise 2

%Zu-Cheng Chen, Mar 2019

%% Data generation parameters

nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;
snr = 10;

%% Exercise 2-1 
% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m

% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. 
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

fltrOrdr = 30;
psdVals = [posFreq(:),psdPosFreq(:)];
noiseVec = statgaussnoisegen(nSamples,psdVals,fltrOrdr,sampFreq);

figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);
xlabel('Frequency (Hz)');
ylabel('PSD ((data unit)^2/Hz)');

figure;
plot(timeVec,noiseVec)
xlabel('Time (sec)');
ylabel('Data');

%% Exercise 2-2 
% Add the signal with an SNR=10 to the noise realization

% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);

[sigVec, normFactor] = normSig(sigVec, sampFreq, psdPosFreq, snr);
dataVec = noiseVec + sigVec;

%% Exercise 2-3 
% Time domain: Plot the data (signal+noise) realization and the signal

figure;
plot(timeVec,dataVec);
hold on;
plot(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');

%% Exercise 2-4 
% Frequency domain: Plot the periodogram of the noise and data together

%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftData = fft(dataVec);
fftSigNoise = fft(noiseVec);
% Discard negative frequencies
fftData = fftData(1:kNyq);
fftSigNoise = fftSigNoise(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftData));
hold on;
plot(posFreq,abs(fftSigNoise));

%% Exercise 2-5 
% Time-frequency domain: Plot the spectrogram of the data

% Make spectrogram with different time-frequency resolution

figure;
spectrogram(dataVec, 128,127,[],sampFreq);

%%Exercise #2

% Yu Sang, Mar 5th 2019

nSamples = 2048;
% Sampling frequency of the data to be generated (should be less than half
% of the maximum frequency in target PSD.
sampFreq = 2048;



%% Generate simulated GW detector noise
% File containing target sensitivity curve (first column is frequency and
% second column is square root of PSD).
targetSens = load('iLIGOSensitivity.txt');

% Select pass band.
fLow = 40;%Hz
fHigh = 1024;%Hz
indxfCut = targetSens(:,1)<= fLow | targetSens(:,1)>= fHigh;
targetSens(indxfCut,2)= 1;

% We only include frequencies up to the Nyquist frequency (half of sampling
% frequency)
indxfCut = targetSens(:,1)<=sampFreq/2;
% Truncate the target PSD to Nyquist frequency.
targetSens = targetSens(indxfCut,:);

%%
% Add 0 frequency and corresponding PSD value
% as per the requirement of FIR2. Similarly add Nyquist frequency.
if targetSens(1,1) > 0 
    addZero = 1;
else
    addZero = 0;
end
if targetSens(end,1) < sampFreq/2
    addNyq = 1;
else
    addNyq = 0;
end
%%
if addZero
    targetSens = [[0,1];targetSens];
end
if addNyq
    targetSens = [targetSens;[sampFreq/2,1]];
end

posFreq = targetSens(:,1);
psdPosFreq = targetSens(:,2).^2;

% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);

%% Add the signal your team was assigned with an SNR=10 to the noise realization
% This is the target SNR
snr = 100;
% Signal parameters
f0=500;
phi0=3;
A = 1;

timeVec = (0:(nSamples-1))/sampFreq;

% Generate the signal
sigVec = gensinsig(timeVec,A,f0,phi0);


% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq_regular = (0:(kNyq-1))*(1/dataLen);
% interpolating the modified PSD to a regular grid of frequency values
psdPosFreq_regular = interp1(posFreq, psdPosFreq, posFreq_regular);

% figure;
% plot(posFreq_regular,psdPosFreq_regular);
% axis([0,posFreq_regular(end),0,max(psdPosFreq_regular)]);
% xlabel('Frequency (Hz)');
% ylabel('PSD ((data unit)^2/Hz)');

% normalize the signal with given snr and psd
[NorSigVec,~] = calNorFactor(sigVec, sampFreq, psdPosFreq_regular,snr) ;

%%Time domain: Plot the data (signal+noise) realization and the signal
figure;
plot(timeVec,sigVec+noiseVec);
hold on;
plot(timeVec,sigVec);
% xlabel('Time (sec)');
% ylabel('Data');

%Frequency domain: Plot the periodogram of the noise and data together
fftSig = fft(sigVec);
fftData = fft(sigVec+noiseVec)
figure;
plot(posFreq_regular,abs(fftSig(1:kNyq)));
hold on;
plot(posFreq_regular,abs(fftData(1:kNyq)));

%Time-frequency domain: Plot the spectrogram of the data
figure;
spectrogram(sigVec+noiseVec, 128,127,[],sampFreq);

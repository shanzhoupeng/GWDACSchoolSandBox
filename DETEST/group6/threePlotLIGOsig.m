%%Exercise #2

% Yu Sang, Mar 5th 2019

nSamples = 4096;
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
targetSens(indxfCut,2)=0;

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
    targetSens = [[0,0];targetSens];
end
if addNyq
    targetSens = [targetSens;[sampFreq/2,0]];
end

posFreq = targetSens(:,1);
psdPosFreq = targetSens(:,2).^2;

% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);

%% Add the signal your team was assigned with an SNR=10 to the noise realization
% This is the target SNR
snr = 10;
% Signal parameters
f0=500;
phi0=3;
A = 1;

timeVec = (0:(nSamples-1))/sampFreq;

% Generate the signal
sigVec = gensinsig(timeVec,A,f0,phi0);

%% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
kNyq = floor(nSamples/2)+1;

% File containing target sensitivity curve (first column is frequency and
% second column is square root of PSD).
targetSens = load('iLIGOSensitivity.txt');

% Select pass band.
fLow = 40;%Hz
fHigh = kNyq;%Hz
indxfCut = targetSens(:,1)<= fLow | targetSens(:,1)>= fHigh;
targetSens(indxfCut,2)=0;

% We only include frequencies up to the Nyquist frequency (half of sampling
% frequency)
indxfCut = targetSens(:,1)<=kNyq;
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
if targetSens(end,1) < kNyq
    addNyq = 1;
else
    addNyq = 0;
end
%%
if addZero
    targetSens = [[0,0];targetSens];
end
if addNyq
    targetSens = [targetSens;[kNyq,0]];
end

posFreq = targetSens(:,1);
psdPosFreq = targetSens(:,2).^2;

% interpolating the modified PSD to a regular grid of frequency values
PSDVec = interp1(posFreq, psdPosFreq, 0:1:kNyq-1);
freqPSDVec_intp = [(0:1:kNyq-1)', PSDVec'];

% normalize the signal with given snr and psd
 NorSigVec = calNorFactor(sigVec, sampFreq, freqPSDVec_intp,snr) 

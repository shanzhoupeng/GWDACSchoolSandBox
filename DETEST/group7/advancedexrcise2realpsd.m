%% Exercise2 Simulate data and plot
%% Generate simulated GW detector noise using real PSD
%problem needs to be resolved!!
%fitted psd function can be 0 somewhere,which causes innerproductpsd
%to become infinity!!

%% 
addpath ../../Noise/
addpath ../../DSP/group7/lab1/

%%
% Sampling frequency of the data to be generated (should be less than half
% of the maximum frequency in target PSD.
fs = 4096;%Hz
%signal to noise ratio
snr=10;

%% Generate simulated GW detector noise
% File containing target sensitivity curve (first column is frequency and
% second column is square root of PSD).
targetSens = load('iLIGOSensitivity.txt');
%%
% Plot the target sensitivity.

% loglog(targetSens(:,1),targetSens(:,2));
% xlabel('Frequency (Hz)');
% ylabel('Strain Sensitivity (1/sqrt{Hz})');

%%
% Select pass band.
fLow = 50;%Hz
fHigh = 700;%Hz
indxfCut = targetSens(:,1)<= fLow | targetSens(:,1)>= fHigh;
targetSens(indxfCut,2)=0;

%% Design filter
% B = fir2(N,F,A) designs an Nth order linear phase FIR digital filter with
% the frequency response specified by vectors F and A and returns the
% filter coefficients in length N+1 vector B.  The frequencies in F must be
% given in increasing order with 0.0 < F < 1.0 and 1.0 corresponding to
% half the sample rate.
%%
% FIR filter order
filtOrdr = 1000;
%%
% We only include frequencies up to the Nyquist frequency (half of sampling
% frequency) when designing the filter.
indxfCut = targetSens(:,1)<=fs/2;
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
if targetSens(end,1) < fs/2
    addNyq = 1;
else
    addNyq = 0;
end
%%
if addZero
    targetSens = [[0,0];targetSens];
end
if addNyq
    targetSens = [targetSens;[fs/2,0]];
end

%% Generate noise
nDataSamples = 16384;
timeVec=(0:(nDataSamples-1))/fs;
kNyq = floor(nDataSamples/2)+1;
freqVec=(0:kNyq-1)*fs/(2*(kNyq-1+0.5*mod(nDataSamples,2)));

% if mod(nDataSamples,2)==0
%     freqVec=(0:kNyq-1)*fs/(2*(kNyq-1));
% else
%     freqVec=(0:kNyq-1)*fs/(2*(kNyq-0.5));
% end

% Interplation 
psdVec=interp1(targetSens(:,1),targetSens(:,2),freqVec);

%% Get the out noise with LIGO PSD
outNoise=statgaussnoisegen(nDataSamples,[targetSens(:,1),targetSens(:,2)],filtOrdr,fs);

sigVec=genlcsig(timeVec,1,[.5,1],pi/4);
sigVec=normsig4psd(sigVec,fs,psdVec,snr);


%% plot 
figure;
plot(timeVec,sigVec,'r');
hold on
plot(timeVec,outNoise);
xlabel('time');
ylabel('');
legend('Signal','Colored noise');
title('Data realization ');
%snapnow;
% figure;
% plot((0:(nDataSamples-1))/fs,10^22*5*outputNoise,'r');
% hold on
% plot((0:(nDataSamples-1))/fs,inNoise);
% legend('outNoise','inNoise');
% snapnow;

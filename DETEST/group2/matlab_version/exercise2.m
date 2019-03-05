nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;
snr = 10;

%%
% Generate the signal that is to be normalized
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; 
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);

%%
% Generate the PSD vector to be used in the normalization. Should be
% generated for all positive DFT frequencies. 
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);
xlabel('Frequency (Hz)');
ylabel('PSD ((data unit)^2/Hz)');



%% Generate a realization of initial LIGO noise using NOISE/statgaussnoisegen.m
fltrOrdr = 30;
psdVals = [posFreq(:),psdPosFreq(:)];
noiseVec = statgaussnoisegen(nSamples,psdVals,fltrOrdr,sampFreq);

figure;
plot(timeVec,noiseVec);
hold on;
plot(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');


%%
Add the signal your team was assigned with an SNR=10 to the noise realization
psdPosFreq = psds(1:kNyq);
%%







% We will use the noise PSD used in colGaussNoiseDemo.m but add a constant
% to remove the parts that are zero. (Exercise: Prove that if the noise PSD
% is zero at some frequencies but the signal added to the noise is not,
% then one can create a detection statistic with infinite SNR.)




[sigNoiseVec, estSNR] = SNRCalc(sigVec, sampFreq, psdPosFreq, snr);

figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);

figure
plot(timeVec,sigVec);
xlabel('Time (sec)');
ylabel('Data');

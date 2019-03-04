SNR=10;
nSamples = 2048;
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;

%addpath ../NOISE/
%addpath ../DSP/group1/lab1/

%% PSD of noise
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 +1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%% Generating noise
noiseVec = statgaussnoisegen(nSamples,[posFreq;psdPosFreq]',500,sampFreq);
%look at the generated PSD
pwelch(noiseVec, 64,[],[],sampFreq);
%% Generating signal
t0=0.5;
f0=100;
f1=150;
phi0=0;
sigVec=lcsig(timeVec,10,[ f0, f1,phi0]);
%normalizing to SNR
[sigVec,myfac]=Exercise1_normcalc( sigVec, sampFreq, psdPosFreq, SNR );
%% Time domain
figure;
hold on;
xlabel('Time(s)');
ylabel(['Noise+GaussianChirp [t0, sigma, f0, phi0]=',mat2str([t0, sigma, f0, phi0])] );
plot(timeVec,sigVec+noiseVec);

%% Frequency domain
fftsig=fft(noiseVec+sigVec);
L=length(noiseVec);
figure;
hold on;
xlabel('Frequency(Hz)');
ylabel('Noise+ SineGaussian signal');
plot(sampFreq*(0:L/2)/L,abs(fftsig(1:L/2+1)));

%% Spectrogram

figure;
spectrogram(noiseVec+sigVec, 128,127,[],sampFreq);

sampFreq = 1024; %Hz
%Number of samples to generate
nSamples = 16384;
%Time samples
timeVec = (0:(nSamples-1))/sampFreq;

%Target PSD given by the inline function handle
targetPSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000;

%Plot PSD
Freqvec = 0:0.1:512;
myPSD = targetPSD(Freqvec);
Trf=[Freqvec;myPSD];

outN = lab5_ColGaussNoise( nSamples, Trf, 500, 1024);
figure;
pwelch(outN, 512,[],[],sampFreq);
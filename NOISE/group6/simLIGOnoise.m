%% Simulating LIGO noise

%Yu Sang, Mar 5th 2019

% First column is Frequency and second column is is sqrt(PSD)
LIGOsen = load('iLIGOSensitivity.txt','-ascii');
% plot
figure
loglog(LIGOsen(:,1),LIGOsen(:,2))

% for f <= 50 Hz, Sn = Sn(f=50);
% for f >= 700Hz, Sn = Sn(f=700);
LIGOsen(1:42,2) = LIGOsen(43,2);
LIGOsen(70:97,2) = LIGOsen(69,2);
%plot
figure
loglog(LIGOsen(:,1),LIGOsen(:,2))

nSamples = 16384;
sampFreq = 4096;

% choose the target frequency band of (0,sampFreq/2);
freqPSDVec = LIGOsen(1:80,:);
% add f=0 and f=sampFreq/2 to the list
freqPSDVec = [[0,0];freqPSDVec;[sampFreq/2,0]];

% interpolating the modified PSD to a regular grid of frequency values
PSDVec = interp1(freqPSDVec(:,1), freqPSDVec(:,2), 0:1:sampFreq/2);
freqPSDVec_intp = [ (0:1:sampFreq/2)', PSDVec'];

%Generating Colored Gaussian noise
colGN = genColGauNoise(nSamples,freqPSDVec_intp,100,sampFreq);

%plot
figure
plot(colGN)

% Estimate the PSD
figure;
pwelch(colGN, 512,[],[],sampFreq);


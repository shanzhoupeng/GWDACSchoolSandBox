sampFreq = 4096; %Hz
%Number of samples to generate
nSamples = 16384;

mynoise=load('iLIGOSensitivity.txt','-ascii');
semilogy(mynoise(:,1),mynoise(:,2),'o','displayname','original');%original sqrt PSD
hold on;

mynoise(1:40,2)=mynoise(41,2);%manually set lower cutoff
%mynoise(66:97,2)=-(mynoise(66,2)-mynoise(97,2))/(mynoise(66,1)-mynoise(97,1))*(mynoise(66:97,1)-mynoise(97,1)); 
mynoise(66:97,2)=mynoise(66,2);%manually set upper cutoff
semilogy(mynoise(:,1),mynoise(:,2)); %modified

outN = lab5_ColGaussNoise( nSamples, mynoise', 500, sampFreq);
figure;
pwelch(outN, 512,[],[],sampFreq);
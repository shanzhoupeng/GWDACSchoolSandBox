% In this exercise we check the SNR of signal in some noise.
% Xiao Xue, Group4, Mar 2019

nSamples = 4096;
sampFreq = 2048;
Time = nSamples/sampFreq;
timeVec = (0:(nSamples-1))/sampFreq;
kNyq = floor(nSamples/2)+1;
%% PSD function design and realization

% design a PSD
noisePSD = @(f) (f>=200 & f<=800).*(f-200).*(800-f)/90000+1;

% plot the noise PSD
freqVec  = (0:(kNyq-1))/Time;
psdVec = noisePSD(freqVec);

subplot(2,2,1)
plot(freqVec, psdVec)
xlabel('Frequency (Hz)')
ylabel('PSD value')

%% Normalize the signal
% create signal
sig0 = crcbgenfmsig(timeVec,1,[300,200,1,3]);

% calculate the norm
normfactor = innerprod(sig0, sig0, sampFreq, psdVec);

snr=10;
sigVec = snr*sig0/sqrt(normfactor);

subplot(2,2,2)
plot(timeVec,sigVec)
xlabel('Time (sec)')
ylabel('Normalized Signal')

%% Test the SNR
% for Null hypothesis
nH0data = 1000;
llrH0 = zeros(1,nH0data);
for lp = 1:nH0data
    noiseVec = statgaussnoisegen(nSamples,[freqVec(:),psdVec(:)],100, sampFreq);
    llrH0(lp)= innerprod(noiseVec, sigVec, sampFreq, psdVec);
end
% for Signal hypothesis
nH1data = 1000;
llrH1 = zeros(1,nH1data);
for lp = 1:nH0data
    noiseVec = statgaussnoisegen(nSamples,[freqVec(:),psdVec(:)],100, sampFreq);
    dataVec = noiseVec + sigVec;
    llrH1(lp)= innerprod(dataVec, sigVec, sampFreq, psdVec);
end

estSNR = (mean(llrH1) - mean(llrH0))/std(llrH0);

subplot(2,2,3)
histogram(llrH0);
hold on
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H0','H1');
title(['Estimated SNR = ', num2str(estSNR)]);

%% Data realization (with the last noiseVec and dataVec)
subplot(2,2,4)
plot(timeVec,dataVec)
hold on
plot(timeVec,sigVec)
xlabel('Time (sec)')
ylabel('Data and Signal')
title('Data Realization')
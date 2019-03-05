function [normsig, normfac] = Exercise1_normcalc( sigVec, sampFreq, psdPosFreq, SNR )
%formfac = normcalc( sigVec, SamplFreq, psdVals, SNR )
%Exercise 1:
%given the signal vector, sampling frequency, PSD and SNR, calculate the
%normalization factor so that the signal have the desired SNR.

%% number of samples is the length of signal vector
nSamples = length(sigVec);

%% positive frequency values
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

%% sanity check
if length(posFreq)~=length(psdPosFreq)
    error('Number of PSD values should match the number of positive DFT frequencies based on the length of the signal vector')
end

%% just testing
figure;
plot(posFreq,psdPosFreq);
axis([0,posFreq(end),0,max(psdPosFreq)]);
xlabel('Frequency (Hz)');
ylabel('PSD ((data unit)^2/Hz)');

%% inner product
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
normfac=SNR/sqrt(normSigSqrd);
normsig=sigVec*normfac;

end


function [normSigVec, normFactor] = normSig(sigVec, sampFreq, psdPosFreq, snr)
%   normSig(sigVec, sampFreq, psdPosFreq, snr)
% Return the normalized signal vector and the normlization factor.
% sigVec: signal vector
% sampFreq: sample frequency
% psdPosFreq: PSD at positive DFT frequencies
% snr: signal-to-noise ratio

%Zu-Cheng Chen, Mar 2019

nSamples = length(sigVec);
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

if kNyq ~= length(psdPosFreq)
    error('Number of PSD values should match the number of positive DFT frequencies based on the length of the signal vector');
end

% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
normFactor = snr/sqrt(normSigSqrd);
% Normalize signal to specified SNR
normSigVec = normFactor*sigVec;
end
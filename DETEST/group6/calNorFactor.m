function [NorSigVec, NorFac] = calNorFactor(sigVec, sampFreq, psdPosFreq,snr) 
%calculates the normalization factor for a given signal and noise PSD

% Yu Sang, Mar 4th 2019

% a sanity check
nSamples = length(sigVec);
kNyq = floor(nSamples/2)+1;
if length(psdPosFreq) ~= kNyq
    error('PSD values must be specified at positive DFT frequencies');
end

%% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
% Normalize signal to specified SNR
NorSigVec = snr*sigVec/sqrt(normSigSqrd);
NorFac = snr/sqrt(normSigSqrd);

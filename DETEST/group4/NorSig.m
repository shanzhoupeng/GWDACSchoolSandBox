function [norsigVec,norfac] = NorSig(sigVec,sampFreq,noisePSD,SNR)
% Normalize signal to specified SNR
nSamples = length(sigVec);
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);
norfac = sqrt(innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq));
norsigVec = SNR*sigVec/norfac;
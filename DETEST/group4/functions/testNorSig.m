function [norsigVec,norfac] = testNorSig(timeVec,x,sampFreq,SNR)
% Normalize signal to specified SNR with given PSD
nSamples = length(timeVec);
phaseVec = x(1)*timeVec + x(2)*timeVec.^2 + x(3)*timeVec.^3;
sigVec = sin(2*pi*phaseVec);
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
% PSD function
noisePSD = @(f) (f>=50 & f<=100).*(f-50).*(100-f)/625+1;
psdPosFreq = noisePSD(posFreq);
norfac = sqrt(innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq));
norsigVec = SNR*sigVec/norfac;
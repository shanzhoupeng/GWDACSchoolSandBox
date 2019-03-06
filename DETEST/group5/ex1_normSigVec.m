function [normSigVec,normFac]=ex1_normSigVec(sigVec,sampFreq,psdPosFreq,snr)
% Calculation of the norm
% Norm of signal squared is inner product of signal with itself
% Normalize signal to specified SNR
normSigSqrd = innerprodpsd(sigVec,sigVec,sampFreq,psdPosFreq);
normFac=snr/sqrt(normSigSqrd);
normSigVec=sigVec*normFac;
end
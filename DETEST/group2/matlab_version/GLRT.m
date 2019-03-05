function LG = GLRT(dataVec,sigVec,sampFreq,psdPosFreq)
%   LR(dataVec,sigVec,sampFreq,psdPosFreq)
%Obtain LLR values for multiple noise realizations

%Zu-Cheng Chen, Mar 2019

normSigVec = normSig(sigVec, sampFreq, psdPosFreq, 1);

LG = innerprodpsd(dataVec,normSigVec,sampFreq,psdPosFreq)^2;
end
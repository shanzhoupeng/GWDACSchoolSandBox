function LG = fitFunc(dataVec,qcCoefs,sampFreq,psdPosFreq)
%   LR(dataVec,sigVec,sampFreq,psdPosFreq)
%Obtain LLR values for multiple noise realizations

%Zu-Cheng Chen, Mar 2019

% Number of samples and sampling frequency.
nSamples = length(dataVec);
timeVec = (0:(nSamples-1))/sampFreq;

sigVec = crcbgenqcsig(timeVec,1,qcCoefs);

[normSigVec, ~] = normSig(sigVec, sampFreq, psdPosFreq, 1);

LG = innerprodpsd(dataVec,normSigVec,sampFreq,psdPosFreq)^2;
end
function llr = LR(dataVec,sigVec,sampFreq,psdPosFreq)
%   LR(dataVec,sigVec,sampFreq,psdPosFreq)
%Obtain LLR values for multiple noise realizations

%Zu-Cheng Chen, Mar 2019

llr = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
end
function LR = calLikeRat(dataVec,sigVec,sampFreq,psdPosFreq)
%calculate the Likelihood Ratio for a given data vector

% Yu Sang, Mar 4th 2019

LR = innerprodpsd(dataVec,sigVec,sampFreq,psdPosFreq);
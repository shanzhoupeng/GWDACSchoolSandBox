function LG = GLRT(dataVec,norsigVec,sampFreq,psdVals)
% Calculate GLRT value of a data vector with a signal normalized to specified SNR
LG = (innerprodpsd(dataVec,norsigVec,sampFreq,psdVals))^2;

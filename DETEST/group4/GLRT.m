function LG = GLRT(dataVec,norsigVec,sampFreq,psdVals)
% Calculate GLRT value of a data vector with a signal normalized to specified SNR
% Wenhong Ruan, Group4, Mar 2019
LG = (innerprod(dataVec,norsigVec,sampFreq,psdVals))^2;

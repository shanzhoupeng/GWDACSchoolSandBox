function GLR = calGLR(dataVec,sigVec,sampFreq,psdPosFreq)
%calculate the Likelihood Ratio for a given data vector

% Yu Sang, Mar 5th 2019

norSigVec = normsig4psd(sigVec, sampFreq, psdPosFreq, snr);

GLR = innerprodpsd(dataVec,norSigVec,sampFreq,psdPosFreq)^2;
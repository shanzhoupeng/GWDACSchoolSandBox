function ex4p1 = GLRT(dataVec,sigVec,sampFreq,psdPosFreq)
% GLRT(dataVec,sigVec,sampFreq,psdPosFreq)
%output: GLRT value
normSigVec = normsig4psd(sigVec, sampFreq, psdPosFreq,1);

ex4p1 = innerprodpsd(dataVec,normSigVec,sampFreq,psdPosFreq)^2;
end
function sigVec = crcbgenfmsig(dataX,snr,qcCoefs)
% Generate a quadratic chirp signal
% Wenfeng Cui, Group4, Mar 2019

phaseVec = qcCoefs(1)*dataX + qcCoefs(3)*cos(2*pi* qcCoefs(2)*dataX);
sigVec = sin(2*pi*phaseVec);
sigVec = snr*sigVec/norm(sigVec);

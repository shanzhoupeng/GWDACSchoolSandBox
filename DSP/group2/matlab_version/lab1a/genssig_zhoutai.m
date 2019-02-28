function sigVec = genssig(dataX,qcCoefs)
% Generate a sinusoid.
% S = GENSSIG(X,C)
% Generate a sine signal S. X is the vector of time stamps at which the
% samples of the signal are to be computed. C is the vector of three 
% coefficients [a1, a2, a3] that parametrize the amplitude, frequency and
% phase of the signal.

% Tai Zhou, Feb 2019

phaseVec = 2*pi*qcCoefs(2)*dataX+qcCoefs(3);
sigVec=qcCoefs(1)*sin(phaseVec);
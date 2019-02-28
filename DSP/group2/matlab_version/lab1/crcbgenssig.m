function sigVec = crcbgenssig(dataX,snr,qcCoefs)
% Generate a sine signal
% S = CRCBGENSSIG(X,SNR,C)
% Generates a sine signal S. X is the vector of time stamps at which the
% samples of the signal are to be computed. SNR is the matched filtering
% signal-to-noise ratio of S and C is the vector of two coefficients
% [a1, a2] that parametrize the frequency and the phase of the signal. 

% Tai Zhou, Feb 2019

phaseVec = 2*pi*qcCoefs(1)*dataX+qcCoefs(2);
sigVec = sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);
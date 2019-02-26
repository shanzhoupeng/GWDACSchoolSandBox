function sigVec = crcbgensgsig(dataX,snr,qcCoefs)
% Generate a sine-gaussian signal
% S = CRCBGENSGSIG(X,SNR,C)
% Generates a sine-gaussian signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% four coefficients [a1, a2, a3, a4] that parametrize the time constant, 
% sigma, frequency and phase of the signal. 

% Tai Zhou, Feb 2019

phaseVec = 2*pi*qcCoefs(3)*dataX+qcCoefs(4);
sigVec = exp(-(dataX-qcCoefs(1)).^2/2/qcCoefs(2)^2).*sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);
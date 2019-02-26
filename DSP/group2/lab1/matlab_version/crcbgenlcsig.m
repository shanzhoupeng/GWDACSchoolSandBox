function sigVec = crcbgenlcsig(dataX,snr,qcCoefs)
% Generate a linear chirp signal
% S = CRCBGENLCSIG(X,SNR,C)
% Generates a linear chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% three coefficients [a1, a2, a3] that parametrize the phase of the signal:
% 2*pi*(a1*t+a2*t^2)+a3. 

% Tai Zhou, Feb 2019

phaseVec = 2*pi*(qcCoefs(1)*dataX + qcCoefs(2)*dataX.^2) + qcCoefs(3);
sigVec = sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);
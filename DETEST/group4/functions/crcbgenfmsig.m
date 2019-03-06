function sigVec = crcbgenfmsig(dataX,snr,qcCoefs)
% Generate a quadratic chirp signal
% S = CRCBGENFMSIG(X,SNR,C)
% Generates a quadratic chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% three coefficients [f0, f1, b/(2*pi)] that parametrize the phase of the
% signal:
% f0*t+ b/(2*pi)*cos(2*pi*f1*t)
%Soumya D. Mohanty, May 2018

phaseVec = qcCoefs(1)*dataX + qcCoefs(3)*cos(2*pi* qcCoefs(2)*dataX);
sigVec = sin(2*pi*phaseVec);
sigVec = snr*sigVec/norm(sigVec);

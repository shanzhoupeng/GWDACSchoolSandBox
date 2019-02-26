function sigVec = gensinsig(dataX,snr,f0,phi0)
% Generate a sinusoudal signal
% S = GENSINSIG(X,SNR,F0,PHI0)
% Generates a sinusoudal signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S. F0 is the frequency and
% PHI0 is the phase of the signal. 

%Yu Sang, Feb 26th 2019

sigVec = sin(2*pi*f0*dataX+phi0);
sigVec = snr*sigVec/norm(sigVec);



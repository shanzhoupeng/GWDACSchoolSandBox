function sigVec = sgsig(dataX,snr,sgCoefs)
% Generate a Sine-Gaussian signal
% S = lcsig(X,SNR,C)
% Generates a Sine-Gaussian signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% four coefficients [t0, sigma, f0, phi0] that parametrize the signal:
% exp( - (dataX-sgCoefs(1))^2 /2/sgCoefs(2)^2 ) * sin(2*pi*sgCoefs(3)*dataX + sgCoefs(4))

%Shuo Xin, Feb 2019

sigVec = exp( - (dataX-sgCoefs(1)).^2 /2/sgCoefs(2)^2 ).* sin(2*pi*sgCoefs(3)*dataX + sgCoefs(4));
sigVec = snr*sigVec/norm(sigVec);



function sigVec = multiSin(dataX,snr,mSCoefs)
% Generate a sinusoids signal
% S = MULTISIN(X,SNR,C)
% Generates a sinusoids signal. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of sinusoids signal. C is the vector of
% two coefficients [f1, phi1] that parametrize the signal:
% snr*sin(2*pi*mSCoefs(1)*dataX + mSCoefs(2));

%Shucheng Yang, Feb 2019
sigVec = sin(2*pi*mSCoefs(1)*dataX+ mSCoefs(2));
sigVec = snr * sigVec/norm(sigVec);



function sigVec = genlcsig(dataX,snr,lcCoefs,iniPhs)
% Generate a linear chirp signal
% S = GENLCSIG(X,SNR,C,D)
% Generates a linear chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and C is the vector of
% two coefficients [a1, a2] that parametrize the phase of the signal:
% a1*t+a2*t^2. D is the initial phase of the signal.

%Jing Chen, David Zhang, Feb 2019

phaseVec = lcCoefs(1)*dataX + lcCoefs(2)*dataX.^2 ;
sigVec = sin(2*pi*phaseVec+iniPhs);
sigVec = snr*sigVec/norm(sigVec);



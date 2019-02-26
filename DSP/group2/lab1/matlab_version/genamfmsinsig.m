function sigVec = genamfmsinsig(dataT,snr,b,f0,f1)
% Generate a AM-FM sinusoid signal
% S = GENFMSINSIG(T,SNR,B,F0,F1)
% Generates a amplitude AM-FM sinusoid S. T is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and [B,F0,F1] are
% three coefficients that parametrize the phase of the signal. 

%Zu-Cheng Chen, Feb 2019

phaseVec01 = 2*pi*f1*dataT;
phaseVec02 = 2*pi*f0*dataT + b*cos(2*pi*f1*dataT);
sigVec = cos(phaseVec01) * sin(phaseVec02);
sigVec = snr*sigVec/norm(sigVec);
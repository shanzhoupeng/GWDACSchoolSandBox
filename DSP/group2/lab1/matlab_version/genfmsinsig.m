function sigVec = genfmsinsig(dataT,snr,b,f0,f1)
% Generate a frequency modulated (AM) sinusoid signal
% S = GENFMSINSIG(T,SNR,B,F0,F1)
% Generates a amplitude modulated (AM) sinusoid S. T is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and [B,F0,F1] are
% three coefficients that parametrize the phase of the signal:
% 2*pi*F0*T + b*cos(2*pi*F1*T). 

%Zu-Cheng Chen, Feb 2019

phaseVec = 2*pi*f0*dataT;
phaseVec = phaseVec + b*cos(2*pi*f1*dataT);
sigVec = sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);
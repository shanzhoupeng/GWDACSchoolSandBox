function sigVec = genamsinsig(dataT,snr,f0,f1,phi0)
% Generate a amplitude modulated (AM) sinusoid signal
% S = GENFMSINSIG(T,SNR,F0,F1,PHI0)
% Generates a amplitude modulated (AM) sinusoid S. T is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and [F0,F1,PHI0] are
% three coefficients that parametrize the phase of the signal:
% 2*pi*F0*T + b*cos(2*pi*F1*T). 

%Zu-Cheng Chen, Feb 2019

phaseVec01 = 2*pi*f1*dataT;
phaseVec02 = f0*dataT + phi0;
sigVec = cos(phaseVec01) * sin(phaseVec02);
sigVec = snr*sigVec/norm(sigVec);
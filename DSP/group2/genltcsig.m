function sigVec = genltcsig(dataT,snr,ta,f0,f1,phi0,L)
% Generate a linear transient chirp signal
% S = GENLSIG(T,SNR,TA,F0,F1,PHI0,L)
% Generates a linear transient chirp signal S. T is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% [TA,F0,F1,PHI0] are four coefficients that parametrize the phase 
% of the signal:
% 2*pi*(F0*(T-TA) + F1*(T-TA)^2) + PHI0). 

%Zu-Cheng Chen, Feb 2019

if dataT<ta | dataT>ta+L
    sigVec = zeros(length(dataT),1);
else
    phaseVec = f0*(dataT-ta) + f1*(dataT-ta).^2;
    phaseVec = 2*pi*phaseVec + phi0;
    sigVec = sin(phaseVec);
    sigVec = snr*sigVec/norm(sigVec);
end
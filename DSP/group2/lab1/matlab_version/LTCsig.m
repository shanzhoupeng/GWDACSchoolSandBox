function sigVec = LTCsig(dataT,snr,ta,f0,f1,phi0,L)
% Generate a linear transient chirp signal
% S = GENLSIG(T,SNR,TA,F0,F1,PHI0,L)
% Generates a linear transient chirp signal S. T is the vector of
% time stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% [TA,F0,F1,PHI0] are four coefficients that parametrize the phase 
% of the signal:
% 2*pi*(F0*(T-TA) + F1*(T-TA)^2) + PHI0). 

%Zu-Cheng Chen, Feb 2019

sigVec = zeros(size(dataT));
for i=1:length(dataT)
    sigVec(i) = ltcsig(dataT(i),ta,f0,f1,phi0,L);
end
sigVec = snr*sigVec/norm(sigVec);
end

function sig = ltcsig(t,ta,f0,f1,phi0,L)
% Generate a linear transient chirp signal
% S = GENLSIG(T,SNR,TA,F0,F1,PHI0,L)
% Generates a linear transient chirp signal S. 
% T is the time stamp at which the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S and 
% [TA,F0,F1,PHI0] are coefficients that parametrize the phase 
% of the signal:
% 2*pi*(F0*(T-TA) + F1*(T-TA)^2) + PHI0). 

%Zu-Cheng Chen, Feb 2019

if t<ta || t>ta+L
    sig = 0;
else
    phase = f0*(t-ta) + f1*(t-ta).^2;
    phase = 2*pi*phase + phi0;
    sig = sin(phase);
end    
end
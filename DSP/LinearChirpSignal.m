function sigVec = LinearChirpSignal(dataX,snr,qcCoefs,initialPhase)
% Generate a Linear chirp signal
% S = LinearChirpSignal(dataX,snr,qcCoefs,initialPhase)
% Generates a Linear chirp signal S. dataX is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S and qcCoefs is the vector of
% three coefficients [a1, a2] that parametrize the phase of the signal:
% a1*t+a2*t^2. 

%Jing Chen, Feb 2019

phaseVec = qcCoefs(1)*dataX + qcCoefs(2)*dataX.^2 ;
sigVec = sin(2*pi*phaseVec+initialPhase);
sigVec = snr*sigVec/norm(sigVec);



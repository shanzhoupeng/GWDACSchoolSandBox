function sigVec = genlcsig(dataX,ampl,lcCoefs,iniPhs)
% Generate a linear chirp signal
% S = GENLCSIG(X,A,C,D)
% Generates a linear chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. 
% A is the amlitude of S and C is the vector of
% two coefficients [a1, a2] that parametrize the phase of the signal:
% a1*t+a2*t^2. D is the initial phase of the signal.

% S=Asin(2pi(a1*t+a2*t^2)+D)
%Jing Chen, David Zhang, Feb 2019

phaseVec = lcCoefs(1)*dataX + lcCoefs(2)*dataX.^2 ;
sigVec = sin(2*pi*phaseVec+iniPhs);
sigVec = ampl*sigVec;



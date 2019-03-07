function sigVec = gensinusig(dataX,aplide,fqcy,iniPhs)
% Generate a sinusoid signal
% S = GENSINUSIG(X,A,F,D)
% Generates a sinusoid signal S. X is the vector of time stamps
% at which the samples of the signal are to be computed. A is
% the amplitude of S and F is the frequency. D is the initial 
% phase of the signal.
% S=Asin(Ft+D)

%David Zhang, Mar 2019

phaseVec = fqcy*dataX;
sigVec = sin(2*pi*phaseVec+iniPhs);
sigVec = aplide*sigVec;
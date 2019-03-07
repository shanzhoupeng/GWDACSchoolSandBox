function glrValue=glrt4qc(dataVec,aqcCoefs,sampFreq,psdVec)
% Calculate the generalized likelihood ratio for quadratic chirp template
% [LR]=GLRT4UNKNOWNAPL(Y,C,Fs,Sn,SNR)
% Y is the signal vector in noise with PSD specified by vector Sn. The PSD 
% should be specified at the positive DFT frequencies corresponding to the 
% length of Y and sampling frequency Fs.The generalized likelihood ratio is
% returned in LR. C is the vector of three coefficients [a1, a2, a3] that 
% parametrize the phase of the signal:
% a1*t+a2*t^2+a3*t^3. 

%PSD length must be commensurate with the length of the signal DFT 
addpath ../../DSP/
nSamples = length(dataVec);
kNyq = floor(nSamples/2)+1;
if length(psdVec) ~= kNyq
    error('Length of PSD is not correct');
end
% Parameters for template

% Amplitude value does not matter as it will be changed in the normalization
A = 1; %snr
tepVec=crcbgenqcsig((0:(nSamples-1))/sampFreq,A,[aqcCoefs(1),aqcCoefs(2),aqcCoefs(3)]);
normTepVec=normsig4psd(tepVec,sampFreq,psdVec,1);
glrValue=innerprodpsd(dataVec,normTepVec,sampFreq,psdVec);
glrValue=glrValue^2;
function glrValue=glrt4UnknownApl(dataVec,sampFreq,psdVec)
% Calculate the generalized likelihood ratio for a given data with unknown
% amplitude(for certain template and can be modified to different
% template).
% [LR]=GLRT4UNKNOWNAPL(Y,Fs,Sn,SNR)
% Y is the signal vector in noise with PSD specified by vector Sn. The PSD 
% should be specified at the positive DFT frequencies corresponding to the 
% length of Y and sampling frequency Fs.The generalized likelihood ratio is
% returned in LR. 

%PSD length must be commensurate with the length of the signal DFT 
addpath ../../DSP/
nSamples = length(dataVec);
kNyq = floor(nSamples/2)+1;
if length(psdVec) ~= kNyq
    error('Length of PSD is not correct');
end
% Parameters for template
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; %snr
tepVec=crcbgenqcsig((0:(nSamples-1))/sampFreq,A,[a1,a2,a3]);
normTepVec=normsig4psd(tepVec,sampFreq,psdVec,1);
glrValue=innerprodpsd(dataVec,normTepVec,sampFreq,psdVec);
glrValue=glrValue^2;
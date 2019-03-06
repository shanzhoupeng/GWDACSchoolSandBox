function LLR = Exercise5( dataVec,sampFreq,psdPosFreq,Hypo_sigpar )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

%% Template for LR
% We will obtain the LR (after amplitude maximization) for the given data
% realization at the following parameter values.
a1=Hypo_sigpar(1);
a2=Hypo_sigpar(2);
a3=Hypo_sigpar(3);
%%
% Generate the template vector for the above parameters.
nSamples=length(dataVec);
timeVec = (0:(nSamples-1))/sampFreq;
sigVec = crcbgenqcsig(timeVec,1,[a1,a2,a3]);
%We do not need the normalization factor, just the signal normalized to
%have snr=1 (i.e., the template vector)
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,1);

%% Calculate LR
LLR = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq)^2;

end


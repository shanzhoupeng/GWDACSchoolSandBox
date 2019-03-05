function LLR = Exercise3_LR(dataVec,sampFreq,Hypo_noiseVec,Hypo_noisePSD,Hypo_sigVec )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明

LLR = innerprodpsd(dataVec,Hypo_noiseVec+Hypo_sigVec,sampFreq,Hypo_noisePSD);
end


function LLR = Exercise3_LR(dataVec,sampFreq,Hypo_noiseVec,Hypo_noisePSD,Hypo_sigVec )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

LLR = innerprodpsd(dataVec,Hypo_noiseVec+Hypo_sigVec,sampFreq,Hypo_noisePSD);
end


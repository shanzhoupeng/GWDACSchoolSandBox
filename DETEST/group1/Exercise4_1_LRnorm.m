function LLR = Exercise4_1_LRnorm( dataVec,sampFreq,Hypo_noisePSD,Hypo_sigVec )
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[Hypo_sigVec, normfac] = normsig4psd( Hypo_sigVec, sampFreq, Hypo_noisePSD, 1 );
[dataVec, normfac] = normsig4psd( dataVec, sampFreq, Hypo_noisePSD, 1 );

LLR = innerprodpsd(dataVec,Hypo_sigVec,sampFreq,Hypo_noisePSD).^2;
end


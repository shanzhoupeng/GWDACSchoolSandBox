
nH0Data = 1000;
llrH0 = zeros(1,nH0Data);
dataVec=sigVec;

for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
        
    llrH0(lp) = Exercise3_LR( dataVec,sampFreq,noiseVec,psdPosFreq,zeros(1,length(noiseVec)) );
end


nH1Data = 1000;
llrH1 = zeros(1,nH1Data);
for lp = 1:nH0Data
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    
    llrH1(lp) =  Exercise3_LR( dataVec,sampFreq,noiseVec,psdPosFreq,sigVec );
end
%%
% Signal to noise ratio estimate
estSNR = (mean(llrH1)-mean(llrH0))/std(llrH0);

figure;
histogram(llrH0);
hold on;
histogram(llrH1);
xlabel('LLR');
ylabel('Counts');
legend('H_0','H_1');
title(['Estimated SNR = ',num2str(estSNR)]);
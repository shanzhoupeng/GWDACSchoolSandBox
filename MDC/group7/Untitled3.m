%% Calculate the significance

  GLRTobs = -outStruct.bestFitness;%
  %% Test
  %Obtain LLR values for multiple noise realizations
  nRealization = 1000;
  GLRTH0 = zeros(1,nRealization);
  for lp = 1:nRealization
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    GLRTH0(lp) = innerprodpsd(noiseVec, dataVec, sampFreq, psdPosFreq);
    GLRTH0(lp) = GLRTH0(lp)^2;
  end  
significance=sum(GLRTH0>=GLRTobs)/nRealization; 
disp(['significance: ',num2str(significance)])

figure 
hold on 
plot(dataVec)
plot(outStruct.bestSig,'r')


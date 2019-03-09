%% Calculate the significance and SNR
% NOTE: 1.This will take several minites 
%       2.Before running this, make sure you have finished running "Mock Data
%         Chanlenge.m" and have not clear the workspace.
%%
nRealization=10;
%%
disp('Calculating the significance and SNR...')

glrtObs = -outStruct.bestFitness;%

% Obtain LLR values for multiple noise realizations
nRealization = 10;
glrtH0 = zeros(1,nRealization);

%Allocate storage
parPsd=struct('posFreq',posFreq(:),'psdPosFreq',psdPosFreq(:));

for lp = 1:nRealization
  inParamsH0(lp) = inParams;
  parPsd(lp) = parPsd(1);
end
%Independent runs of PSO in parallel. Change 'parfor' to 'for' if the
%parallel computing toolbox is not available.
parfor lp = 1:nRealization
  disp([num2str(lp),' of ',num2str(nRealization),' ...'])
  %Reset random number generator for each worker
  rng(lp);
  noiseVec = statgaussnoisegen(nSamples,[parPsd(lp).posFreq,parPsd(lp).psdPosFreq],100,sampFreq);
  inParamsH0(lp).dataY = noiseVec;
  outStructH0(lp) = qcpso(inParamsH0(lp),struct('maxSteps',maxSteps),nRuns);
  glrtH0(lp)=-outStructH0(lp).bestFitness;
  disp([num2str(lp),' of ',num2str(nRealization),' done'])
end
  
%%
estSNR = (glrtObs-mean(glrtH0))/std(glrtH0);  % for certain data realization
disp(['SNR: ',num2str(estSNR)])

significance=sum(glrtH0>=glrtObs)/nRealization;
disp(['significance: ',num2str(significance)])


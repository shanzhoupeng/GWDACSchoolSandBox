%% Caculation significance for given data(1 parameter)
addpath ../
load ('data1.mat')
%%
% Data generation parameters
nSamples = length(dataVec);
sampFreq = 1024;
timeVec = (0:(nSamples-1))/sampFreq;
%% Supply PSD values
% This is the noise psd we will use.
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;
dataLen = nSamples/sampFreq;
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);
%% Template
a1=10;
a2=3;
a3=3;
% Amplitude value does not matter as it will be changed in the normalization
A = 1; %snr
sigVec=crcbgenqcsig(timeVec,A,[a1,a2,a3]);
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,1);
%% 
significance=ones(1,3);
for n=1:3
  load (['data',num2str(n),'.mat']); %dataVec
  llr = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq);
  llrObs = llr^2;
  %% Test
  %Obtain LLR values for multiple noise realizations
  nRealization = 1000;
  llrH0 = zeros(1,nRealization);
  for lp = 1:nRealization
    noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
    llr = innerprodpsd(noiseVec,templateVec,sampFreq,psdPosFreq);
    llrH0(lp) = llr^2;
  end  
significance(n)=sum(llrH0>=llrObs)/nRealization; 
end
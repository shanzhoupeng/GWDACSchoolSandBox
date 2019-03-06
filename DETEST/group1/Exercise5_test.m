for dataindex = [1,2,3]
    %% Reading data
    data1=load(['C:\Users\HP\GWDACSchoolSandBox\DETEST\data',mat2str(dataindex),'.mat']);
    sampFreq=data1.sampFreq;
    dataVec=data1.dataVec;
    nSamples=length(dataVec);
    %% PSD of noise
    noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 +1;
    dataLen = nSamples/sampFreq;
    kNyq = floor(nSamples/2)+1;
    posFreq = (0:(kNyq-1))*(1/dataLen);
    psdPosFreq = noisePSD(posFreq);
    %% estimate significance
    LLR_data  = Exercise5( dataVec,sampFreq,psdPosFreq,[a1,a2,a3] );

    nH0Data = 1000;
    count=0;
    llrH0 = zeros(1,nH0Data);
    for lp = 1:nH0Data
        noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdPosFreq(:)],100,sampFreq);
        dataVec=noiseVec;
        llrH0(lp) = Exercise5( dataVec,sampFreq,psdPosFreq,[a1,a2,a3] );
        if llrH0(lp)>=LLR_data
            count=count+1;
        end
    end
    figure;
    hist(llrH0);
    disp(['data',mat2str(dataindex),' significance: ',mat2str(count/nH0Data)]);
end

disp(['realization #: ',mat2str(nH0Data)]);
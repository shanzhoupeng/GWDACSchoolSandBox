function outputNoise = lab5_ColGaussNoise( Nsamples, TransferFunc, FIRorder, SamplFreq)
%return a Gaussian noise with Nsamples and custom power spectral density,  
%TransferFunc contains the Target PSD (square rooted),
%TransferFunc(1) contains the frequancy points and TransferFunc(2) contains
%the values.

%interplotating the Transfer function
fstep=0.1;%consistent with your script hhh
FreqVec=0:fstep:SamplFreq/2;
sqPSDVec=interp1(TransferFunc(1,:),TransferFunc(2,:),FreqVec);

%Filter Design
myfir=fir2(FIRorder, FreqVec/(SamplFreq/2), sqPSDVec);

%Generate a WGN
inNoise = randn(1,Nsamples);

%pass it through designed filter
outputNoise = fftfilt(myfir,inNoise);

end


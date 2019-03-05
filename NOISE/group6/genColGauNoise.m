function colGN = genColGauNoise(nSamples,freqPSDVec,fltrOrdr,sampFreq)
% Generating Colored Gaussian noise
% Realization of Colored Gaussian noise with the given number of samples 
% and sampling frequency.
% colGN = genColGauNoise(nSamples,freqPSDVec,fltrOrdr,sampFreq)
% colGN is Realization of Colored Gaussian noise, 
% nSamples is Number of samples to generate,
% freqPSDVec is N-by-2 matrix containing [f, sqrt(PSD)] values on each row,
% fltrOrdr is FIR filter order,
% sampFreq is Sampling frequency for noise realization, 
% f must range from 0 to sampFreq/2.

%Yu Sang, Mar 3rd 2019

%Time samples
timeVec = (0:(nSamples-1))/sampFreq;

%Plot PSD
freqVec = freqPSDVec(:,1);
sqrtPSDVec = freqPSDVec(:,2);
psdVec = sqrtPSDVec.^2;
figure;
plot(freqVec,psdVec);

% Design FIR filter with T(f)= square root of target PSD
b = fir2(fltrOrdr,freqVec/(sampFreq/2),sqrtPSDVec);

% Generate a WGN realization and pass it through the designed filter
% (Comment out the line below if new realizations of WGN are needed in each run of this script)
rng('default'); 
inNoise = randn(1,nSamples);
colGN = fftfilt(b,inNoise);

% Plot the colored noise realization
% figure;
% plot(timeVec,colGN);

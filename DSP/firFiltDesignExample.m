%% FIR filter design example
%Sampling frequency
fs = 2048 ;%Hz;

%Number of samples in impulse input sequence
nSamples = 256;

%Sampling times
timeVec = (0:(nSamples-1))/fs;
 
%Filter order
fN = 10;
 
%Frequency values at which to specify
%the target transfer function
f = 0:2:1024;
 
%Target transfer function
targetTf = f.*(1024-f);
 
%Design the digital filter
b = fir2(fN,f/(fs/2),targetTf);
 
%Get the impulse response by letting the filter act on an impulse sequence
impVec = zeros(1,nSamples);
impVec(floor(nSamples/2))=1; %Impulse in the middle
impResp = fftfilt(b,impVec);
 
%Get the transfer function: FFT of impulse response
designTf = fft(impResp);

%Plots
figure;
hold on;
plot(f,targetTf);
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))/(nSamples/fs);
plot(posFreq,abs(designTf(1:kNyq)));

figure;
plot(timeVec,impResp);
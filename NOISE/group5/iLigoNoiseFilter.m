clear
clc
%%  log plot iLIGOSensitivity 
y = load('iLIGOSensitivity.txt','-ascii');
loglog(y(:,1),y(:,2));

%% Modifications
%find low frequency cut point
for i=1:length(y)
    a(i)=abs(y(i,1)-50);
end
low=find(a==min(a))
%find high frequency cut point
for i=1:length(y)
    a(i)=abs(y(i,1)-700);
end
high=find(a==min(a))

y(1:low-1,2) = y(low,2);
% For f>= 700Hz, S_n(f)=S_n(f=700)
y(high+1:length(y),2) = y(low,2);


%% fliter
%Sampling frequency for noise realization
sampFreq = 4096;
nSamples = 16384;
timeVec = (0:(nSamples-1))/sampFreq;
fltrOrdr = 1000;
FreqVec = 0:0.1:sampFreq/2;
% Linear interpolation
sqrtpsd = interp1(y(:,1),y(:,2),FreqVec');
% Design FIR filter
b = fir2(fltrOrdr,FreqVec'/(sampFreq/2),sqrtpsd);
rng('default'); 
Noise = randn(1,nSamples);
outPut = fftfilt(b,Noise);
% Estimate the PSD
figure;
pwelch(outPut, 512,[],[],sampFreq);
    
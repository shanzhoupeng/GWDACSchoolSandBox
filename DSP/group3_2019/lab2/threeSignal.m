%% Plot the AM-FM sinusoid signal

% xinchun hu
% Signal parameters
f0=5;

% Time samples
samplIntrvl=0.001;
timeVec = 0:samplIntrvl:12;

A1=10;  A2=5;  A3=2.5;
f01=100;  f02=200;  f03=300;
phi01=0;  phi02=pi/6;  phi03=pi/4;

% Number of samples
nSamples = length(timeVec);

% Generate the signal call signal model
sigVec = sinusoidSignal(timeVec,A1,f01,phi01)+sinusoidSignal(timeVec,A2,f02,phi02)...
    +sinusoidSignal(timeVec,A3,f03,phi03);  

%Plot the signal 
figure;
plot(timeVec,sigVec)

%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));

[S,F,T]=spectrogram(sigVec, 256,250,[],1000);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

 
%Target transfer function
f = 0:2:1024; fs=2048;
targetTf = f.*(1024-f);
 
%Design the digital filter
b = fir1(30,[0.5 0.7],'stop');

%
impResp = fftfilt(b,sigVec);

%Get the transfer function: FFT of impulse response
designTf = fft(impResp);

%Plots

kNyq = floor(nSamples/2)+1;
figure
plot(posFreq,abs(designTf(1:kNyq)));

[S,F,T]=spectrogram(impResp, 256,250,[],1000);
figure;
imagesc(T,F,abs(S));axis xy;

% Create signals of 3 sine functions and filter it.
% Group4, Xiao Xue, Feb 2019
%% Create Samples
nSamples=2048;
sampFreq=1024;
timeVec=(0:(nSamples-1))/sampFreq;

lenSamp=length(timeVec);

p1=[10,100,0];
p2=[5,200,pi/6];
p3=[2.5,300,pi/4];
sigVec=p1(1)*sin(2*pi*p1(2)*timeVec+p1(3))+p2(1)*sin(2*pi*p2(2)...
    *timeVec+p2(3))+p3(1)*sin(2*pi*p3(2)*timeVec+p3(3));

%% FIR filtering

% Design low pass filter
filtOrdr = 50;
b1 = fir1(filtOrdr,150/(sampFreq/2),'low');
b2 = fir1(filtOrdr,[150/(sampFreq/2),250/(sampFreq/2)],'bandpass');
b3 = fir1(filtOrdr,250/(sampFreq/2),'high');

% Apply filter
filtSig1 = fftfilt(b1,sigVec);
filtSig2 = fftfilt(b2,sigVec);
filtSig3 = fftfilt(b3,sigVec);

%% Signals before and after

% Plot
figure;
subplot(2,3,1)
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig1);

subplot(2,3,2)
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig2);

subplot(2,3,3)
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig3);


%% Doing FFT for samples AND FILTERED samples
dataLen = timeVec(end)-timeVec(1);
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);

fftSig = fft(sigVec);
fftSig = fftSig(1:kNyq);


filtfftSig1 = fft(filtSig1); filtfftSig1 = filtfftSig1(1:kNyq);
filtfftSig2 = fft(filtSig2); filtfftSig2 = filtfftSig2(1:kNyq);
filtfftSig3 = fft(filtSig3); filtfftSig3 = filtfftSig3(1:kNyq);

%% Plot fft results comparison BEFORE(blue) and AFTER(red).
subplot(2,3,4)
hold on;
plot(posFreq,abs(fftSig));
plot(posFreq,abs(filtfftSig1));

subplot(2,3,5)
hold on;
plot(posFreq,abs(fftSig));
plot(posFreq,abs(filtfftSig2));

subplot(2,3,6)
hold on;
plot(posFreq,abs(fftSig));
plot(posFreq,abs(filtfftSig3));
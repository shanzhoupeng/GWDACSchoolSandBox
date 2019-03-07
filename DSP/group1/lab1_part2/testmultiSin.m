%% Plot the sum of 3 sinusoids signal
% Signal parameters

f1=100;
f2=200;
f3=300;

phi1=0;
phi2=pi/6;
phi3=pi/4;

A1 = 10;
A2 = 5;
A3 = 2.5;

% Instantaneous frequency after 1 sec is 
maxFreq = f3;
samplFreq = 1024; %5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:2;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = multiSin(timeVec,A1,[f1,phi1]) + multiSin(timeVec,A2,[f2,phi2]) + multiSin(timeVec,A3,[f3,phi3]);

%Digital filtering
order = 30; %阶数

%lowpass
frqL = 101; %低通截止频率
Wn = frqL/(samplFreq/2);
blo1 = fir1(order,Wn); %Wn = frqL /(samplFreq/2)H
outlo1 = fftfilt(blo1,sigVec);


%bandpass
frqB1 = 199; %带通截止频率1
frqB2 = 201; %带通截止频率2
Wn1 = frqB1/(samplFreq/2);
Wn2 = frqB2/(samplFreq/2);
blo2 = fir1(order,[Wn1,Wn2],'band'); %Wn = frqL /(samplFreq/2)
outlo2 = fftfilt(blo2,sigVec);

%highpass
frqH = 299; %高通截止频率
Wn = frqH/(samplFreq/2);
blo3 = fir1(order,Wn,'high'); %Wn = frqL /(samplFreq/2)
outlo3 = fftfilt(blo3,sigVec);


% 
%Plot the signal 
figure;
subplot(3,1,1)
hold on;
plot(timeVec, sigVec)
plot(timeVec, outlo1)
title('Original Signal and Lowpass Filtered Signal')
xlabel('Time (s)')
% hold off;

subplot(3,1,2)
hold on;
plot(timeVec, sigVec)
plot(timeVec, outlo2)
title('Original Signal and bandpass Filtered Signal')
xlabel('Time (s)')


subplot(3,1,3)
hold on;
plot(timeVec, sigVec)
plot(timeVec, outlo3)
title('Original Signal and highpass Filtered Signal')
xlabel('Time (s)')



% Plot spectrogram (by Shucheng Yang of group1) 
figure;
subplot(2,2,1)
spectrogram(sigVec,256,250,[],samplFreq)
title('Original Signal')

subplot(2,2,2)
spectrogram(outlo1,256,250,[],samplFreq)
title('Lowpass Filtered Signal')

subplot(2,2,3)
spectrogram(outlo2,256,250,[],samplFreq)
title('Bandpass Filtered Signal')

subplot(2,2,4)
spectrogram(outlo3,256,250,[],samplFreq)
title('Highpass Filtered Signal')


%Plot the periodogram
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig1= fft(sigVec);
fftSig2 = fft(outlo1);
fftSig3 = fft(outlo2);
fftSig4 = fft(outlo3);
% Discard negative frequencies
fftSig1 = fftSig1(1:kNyq);
fftSig2 = fftSig2(1:kNyq);
fftSig3 = fftSig3(1:kNyq);
fftSig4 = fftSig4(1:kNyq);

%Plot periodogram
xmin = 0;
xmax = 600;
ymin = 0;
ymax = 300;

figure;
subplot(2,2,1)
plot(posFreq,abs(fftSig1));
title('Original Signal');
axis([xmin xmax ymin ymax]); % 设置坐标轴在指定的区间

subplot(2,2,2)
plot(posFreq,abs(fftSig2));
title('Lowpass Filtered Signal')
axis([xmin xmax ymin ymax]); % 设置坐标轴在指定的区间

subplot(2,2,3)
plot(posFreq,abs(fftSig3));
title('Bandpass Filtered Signal')
axis([xmin xmax ymin ymax]); % 设置坐标轴在指定的区间

subplot(2,2,4)
plot(posFreq,abs(fftSig4));
title('Highpass Filtered Signal')
axis([xmin xmax ymin ymax]); % 设置坐标轴在指定的区间
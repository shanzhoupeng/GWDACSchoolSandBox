%% 3 type of filters 
sampFreq = 1024;
nSamples = 2048;

timeVec = (0:(nSamples-1))/sampFreq; %2 seconds

%% Quadratic chirp signal
% Signal parameters
A1=10;
A2=5;
A3=2.5;
f1 = 100;
f2 = 200;
f3 = 300;
phi1=0;
phi2=pi/6;
phi3=pi/4;
% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
maxFreq = a1 + 2*a2*sigLen + 3*a3*sigLen^2;

disp(['The maximum frequency of the quadratic chirp is ', num2str(maxFreq)]);

% Generate signal
sigVec = gensinusig(timeVec,A1,f1,phi1)+gensinusig(timeVec,A2,f2,phi2)+gensinusig(timeVec,A3,f3,phi3);

%% Plot the periodogram
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


%% --------------------1--------------------------------------


%% Remove frequencies above the minimum frequency
% Design low pass filter
filtOrdr = 30;
b = fir1(filtOrdr,((f1+f2)/2)/(sampFreq/2)); %Nyquist freq = sampFreq/2
% Apply filter
filtSig = fftfilt(b,sigVec);

%% Make periodogram 
% FFT of signal
fftSig = fft(filtSig);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
%% Plots
figure;
hold on;
plot(timeVec,sigVec,'b');
plot(timeVec,filtSig,'r');

%% ----------------------2------------------------------------


%% Remove frequencies below the maximum frequency
% Design high pass filter
filtOrdr = 30;
b = fir1(filtOrdr,((f2+f3)/2)/(sampFreq/2),'high'); %Nyquist freq = sampFreq/2
% Apply filter
filtSig = fftfilt(b,sigVec);

%% Make periodogram 
% FFT of signal
fftSig = fft(filtSig);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
%% Plots
figure;
hold on;
plot(timeVec,sigVec,'b');
plot(timeVec,filtSig,'r');

%% ----------------------3------------------------------------

%% Keep the frequency in the middle
% Design band pass filter
filtOrdr = 30;
b = fir1(filtOrdr,[((f1+f2)/2)/(sampFreq/2) ((f2+f3)/2)/(sampFreq/2)]); %Nyquist freq = sampFreq/2
% Apply filter
filtSig = fftfilt(b,sigVec);

%% Make periodogram 
% FFT of signal
fftSig = fft(filtSig);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
%% Plots
figure;
hold on;
plot(timeVec,sigVec,'b');
plot(timeVec,filtSig,'r');
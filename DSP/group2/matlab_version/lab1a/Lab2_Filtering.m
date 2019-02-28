clear
clc
% generate a signal containing the sum of three sinusoids for filtering
% practice

sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;

dataX = timeVec;

snr1 = 10;
qcCoefs1 = [100,0];

snr2 = 5;
qcCoefs2 = [200,pi/6];

snr3 = 2.5;
qcCoefs3 = [300,pi/4];

sig_sum =  genssig(dataX,snr1,qcCoefs1)+genssig(dataX,snr2,qcCoefs2)+genssig(dataX,snr3,qcCoefs3);
% 
% figure(1)
% plot(dataX,sig_sum);


%% Design low pass filter for sig1

filtOrdr1 = 30;
b1 = fir1(filtOrdr1,150/(sampFreq/2));
filtSig1 = fftfilt(b1,sig_sum);

figure(1);
hold on;
plot(timeVec,sig_sum);
plot(timeVec,filtSig1);

%% Design band pass filter for sig2

filtOrdr2 = 30;
W1 = 150/(sampFreq/2);
W2 = 250/(sampFreq/2);
b2 = fir1(filtOrdr2,[W1 W2],'bandpass');
filtSig2 = fftfilt(b2,sig_sum);



figure(2);
hold on;
plot(timeVec,sig_sum);
plot(timeVec,filtSig2);

% %% Design band pass filter for sig3
% 
% filtOrdr3 = 30;
% W3 = 250/(sampFreq/2);
% W4 = 350/(sampFreq/2);
% b3 = fir1(filtOrdr3,[W3 W4],'bandpass');
% filtSig3 = fftfilt(b3,sig_sum);
% 
% 
% 
% figure(3);
% hold on;
% plot(timeVec,sig_sum);
% plot(timeVec,filtSig3);
% 
% %% Design band pass filter for sig1 
% filtOrdr4 = 30;
% W5 = 50/(sampFreq/2);
% W6 = 150/(sampFreq/2);
% b4 = fir1(filtOrdr4,[W5 W6],'bandpass');
% filtSig4 = fftfilt(b4,sig_sum);
% 
% 
% 
% figure(4);
% hold on;
% plot(timeVec,sig_sum);
% plot(timeVec,filtSig4);

%% Design high pass filter for sig3 
filtOrdr5 = 30;
b5 = fir1(filtOrdr5,250/(sampFreq/2),'high');
filtSig5 = fftfilt(b5,sig_sum);



figure(5);
hold on;
plot(timeVec,sig_sum);
plot(timeVec,filtSig5);






%% FiltSigSig demo

%Yu Sang, Feb 27th 2019
%% FiltSigSig demo
sampFreq = 1024;
nSamples = 2048;
timeVec = (0:(nSamples-1))/sampFreq;% so timeVec is 2 sec.


%% Sinusoid signal
A_1=10;
f0_1=100;
p0_1=0;
A_2=5;
f0_2=200;
p0_2=pi/6;
A_3=2.5;
f0_3=300;
p0_3=pi/4;

% Signal length
sigLen = (nSamples-1)/sampFreq;
%Maximum frequency
maxFreq = max([f0_1,f0_2,f0_3]);

disp(['The maximum frequency of the quadratic chirp is ', num2str(maxFreq)]);

%%
% Generate signal
sigVec = gensinsig(timeVec,A_1,f0_1,p0_1) + gensinsig(timeVec,A_2,f0_2,p0_2) ...
     + gensinsig(timeVec,A_3,f0_3,p0_3);

% %% Remove frequencies above (f0_1 + f0_2)/2
% % Design low pass filter
% filtOrdr = 50;
% b = fir1(filtOrdr,((f0_1+f0_2)/2)/(sampFreq/2));
% % Apply filter
% filtSig = fftfilt(b,sigVec);

% %% Remove frequencies below (f0_2 + f0_3)/2
% % Design high pass filter
% filtOrdr = 50;
% b = fir1(filtOrdr,((f0_2+f0_3)/2)/(sampFreq/2),'high');
% % Apply filter
% filtSig = fftfilt(b,sigVec);

%% Remove frequencies above (f0_2 + f0_3)/2 and below (f0_1 + f0_2)/2
% Design band pass filter
filtOrdr = 50;
b = fir1(filtOrdr,[(f0_1 + f0_2)/2,(f0_2+f0_3)/2]/(sampFreq/2),'bandpass');
% Apply filter
filtSig = fftfilt(b,sigVec);


%% Plots
figure;
hold on;
plot(timeVec,sigVec);
plot(timeVec,filtSig);

%% 
% Make spectrogram with different time-frequency resolution

% figure;
% spectrogram(filtSig, 128,127,[],sampFreq);
% figure;
% spectrogram(filtSig, 256,250,[],sampFreq);

%%
% Make plots independently of the spectrogram function
[S,F,T]=spectrogram(filtSig, 256,250,[],sampFreq);
figure;
imagesc(T,F,abs(S));axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');



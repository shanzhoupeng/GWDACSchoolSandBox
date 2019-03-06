function outNoise = colnoisegen(N,M,fn,fs)
% Generate a colored Gaussian noise
% outNoise = colgen(N,M,fn,fs)
% OutNoise is the vector generated by this function, N is number of
% samples, M is N-by-2 matrix containing [f,sqrt(S_n(f))] values on 
% each row, fn is FIR filter order, fs is sampling frequency

% Sampling frequency vector
FreqVec = 0:0.1:fs/2;
% frequency need start from 0
sqrtpsd = interp1(M(:,1),M(:,2),FreqVec');  
% Design FIR filter
b = fir2(fn,FreqVec'/(fs/2),sqrtpsd);
% Generate a WGN realization and pass it through the designed filter
rng('default'); 
inNoise = randn(1,N);
outNoise = fftfilt(b,inNoise);
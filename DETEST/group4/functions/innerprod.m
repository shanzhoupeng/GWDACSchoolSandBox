%% Exercise 1
% In this function we calcaulate the innerproduct with a given PSD
% function. (redo the coding)
% Xiao Xue, Group4, Mar 2019
function prod = innerprod(vec1,vec2, sampFreq, psdVals)

nSamples = length(vec1);
if length(vec2) ~= nSamples
    error('two vectors must have same length')
end

kNyq = floor(nSamples/2)+1;

if kNyq ~= length(psdVals)
    error ('length of PSD vector must be specified at positive frequency')
end

fft1 = fft(vec1);
fft2 = fft(vec2);

negFStrt = 1-mod(nSamples,2);
psdVec4Norm = [psdVals,psdVals((kNyq-negFStrt):-1:2)];

denom = sampFreq*nSamples;
prod = (1/denom)*(fft1./psdVec4Norm)*fft2';
prod = real(prod);



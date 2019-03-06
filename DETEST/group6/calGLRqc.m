function GLRqc = calGLRqc(dataVec,nSamples,sampFreq,psdPosFreq,qcCoefs)
%Exercise #5: Calculate LR for Quadratic chirp signal
% We will calculate the Likelihood ratio (LR) after maximization over
% amplitude for a quadratic chirp in noise with a given Power Spectral
% Density (PSD).
% input is a given data vector, 
% parameter values a1, a2, a3 for a quadratic chirp,  qcCoefs = [a1,a2,a3]
%and Noise PSD vector at positive DFT frequencies.
% output is value of Likelihood ratio maximized over amplitude

% Yu Sang, Mar 6th 2019

%% time vector for data realization
timeVec = (0:(nSamples-1))/sampFreq;

%% Template for LR
% We will obtain the LR (after amplitude maximization) for the given data
% realization at the given parameter values qcCoefs.
A = 1; 

% Generate the template vector for the above parameters.
sigVec = crcbgenqcsig(timeVec,A,qcCoefs);
%We do not need the normalization factor, just the signal normalized to
%have snr=1 (i.e., the template vector)
snr = 1;
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdPosFreq,snr);

GLRqc = innerprodpsd(dataVec,templateVec,sampFreq,psdPosFreq)^2;
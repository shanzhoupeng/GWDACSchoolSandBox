function [fitVal,varargout] = CGNqcfitfunc(xVec,params)
%Fitness function for quadratic chirp regression with Color Gaussin Noise.
%F = CGNCRCBQCFITFUNC(X,P)
%Compute the fitness function ( the minus log-likelihood ratio for colored 
%noise maximized over amplitude) for data containing the
%quadratic chirp signal. X.  The fitness values are returned in F. X is
%standardized, that is 0<=X(i,j)<=1. The fields P.rmin and P.rmax  are used
%to convert X(i,j) internally before computing the fitness:
%X(:,j) -> X(:,j)*(rmax(j)-rmin(j))+rmin(j).
%The fields P.dataY and P.dataX are used to transport the data and its
%time stamps. The fields P.dataXSq and P.dataXCb contain the timestamps
%squared and cubed respectively.
% P.psd is the PSD for colored noise. The P.psd should be specified at
% the positive DFT frequencies corresponding to the length of signal and
% sampling frequency Fs.
% P.sampFreq is Sampling frequency
%
%[F,R] = CRCBQCFITFUNC(X,P)
%returns the quadratic chirp coefficients corresponding to the rows of X in R. 
%
%[F,R,S] = CRCBQCFITFUNC(X,P)
%Returns the quadratic chirp signals corresponding to the rows of X in S.

%Soumya D. Mohanty
%June, 2011
%April 2012: Modified to switch between standardized and real coordinates.

%Shihan Weerathunga
%April 2012: Modified to add the function rastrigin.

%Soumya D. Mohanty
%May 2018: Adapted from rastrigin function.

%Soumya D. Mohanty
%Adapted from QUADCHIRPFITFUNC
%==========================================================================

%rows: points
%columns: coordinates of a point
[nVecs,~]=size(xVec);

%storage for fitness values
fitVal = zeros(nVecs,1);

%Check for out of bound coordinates and flag them
validPts = crcbchkstdsrchrng(xVec);
%Set fitness for invalid points to infty
fitVal(~validPts)=inf;
xVec(validPts,:) = s2rv(xVec(validPts,:),params);

for lpc = 1:nVecs
    if validPts(lpc)
    % Only the body of this block should be replaced for different fitness
    % functions
        x = xVec(lpc,:);
        fitVal(lpc) = mLRqc(x, params);
    end
end

%Return real coordinates if requested
if nargout > 1
    varargout{1}=xVec;
end

% minus Likelihood ratio (LR) after maximization over
% amplitude for a quadratic chirp
function mLRVal = mLRqc(x,params)
%Generate normalized quadratic chirp
phaseVec = x(1)*params.dataX + x(2)*params.dataXSq + x(3)*params.dataXCb;
qc = sin(2*pi*phaseVec);
%PSD length must be commensurate with the length of the signal DFT 
nSamples = length(qc);
kNyq = floor(nSamples/2)+1;
if length(params.psd) ~= kNyq
    error('Length of PSD is not correct');
end
% Norm of signal squared is inner product of signal with itself
normqc = innerprodpsd(qc,qc,params.sampFreq,params.psd);
% Normalize signal to specified SNR = 1
qc = qc/sqrt(normqc);

%Compute fitness
mLRVal = - innerprodpsd(params.dataY,qc,params.sampFreq,params.psd)^2;

% %Sum of squared residuals after maximizing over amplitude parameter
% function ssrVal = ssrqc(x,params)
% %Generate normalized quadratic chirp
% phaseVec = x(1)*params.dataX + x(2)*params.dataXSq + x(3)*params.dataXCb;
% qc = sin(2*pi*phaseVec);
% qc = qc/norm(qc);
% 
% %Compute fitness
% ssrVal = -(params.dataY*qc')^2;
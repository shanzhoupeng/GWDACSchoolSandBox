function [fitVal,varargout] = testfitfunc(xVec,params)
% Fitness function for quadratic chirp regression

% Wenhong Ruan, group 4, Mar 2019

% rows: points
% columns: coordinates of a point
[nVecs,~]=size(xVec);

% storage for fitness values
fitVal = zeros(nVecs,1);

% Check for out of bound coordinates and flag them
validPts = crcbchkstdsrchrng(xVec);

% Set fitness for invalid points to infty
fitVal(~validPts)=inf;
xVec(validPts,:) = s2rv(xVec(validPts,:),params);

for lpc = 1:nVecs
    if validPts(lpc)
    % functions
        x = xVec(lpc,:);
        fitVal(lpc) = ssrqc(x, params);
    end
end

% Return real coordinates if requested
if nargout > 1
    varargout{1}=xVec;
end

function ssrVal = ssrqc(x,params)
% Generate normalized quadratic chirp in a specified psd
[norsigVec,~] = testNorSig(params.dataX,x,params.sampFreq,1);
% Compute fitness(minus GLRT)
ssrVal = -(innerprodpsd(params.dataY,norsigVec,params.sampFreq,params.psdVals))^2;
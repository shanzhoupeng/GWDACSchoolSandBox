function result = Fplus(theta, phi, angle)
% antenna patten 
% C = Fplus(theta, phi)

% Zu-Cheng Chen, Feb 2019

XBasis = [1, 0, 0];
YBasis = [0, 1, 0];
ZBasis = [0, 0, 1];

rBasis = [sin(theta) * cos(phi), sin(theta) * sin(phi), cos(theta)];

xBasis = vcrossprod(ZBasis, rBasis);
xBasis = xBasis/norm(xBasis);
yBasis = vcrossprod(xBasis, rBasis);

% rotation
xBasis = rotMat(angle) * xBasis';
yBasis = rotMat(angle) * yBasis';
xBasis = xBasis';
yBasis = yBasis';

zBasis = -rBasis;

tensor01 = eplus(xBasis, yBasis);
tensor02 = detTensor(XBasis, YBasis);

result = sum(tensor01(:) .* tensor02(:));
end
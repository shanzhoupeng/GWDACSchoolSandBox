function strnVec = genStrnSig(hpVec, hcVec, phi,theta,psi)
% generate strain signal
% strnVec = genStrnSig(hpVec, hcVec, phi,theta,psi)
% Input is time series vector, source direction and polarization angle.
% hpVec, hcVec are time series vector of h_plus and and h_cross,
% phi and theta is azimuthal and polar angle values respectively.
% The polar angle range is 0 (z-axis) to 180 (negative z-axis).
% psi is the polarization angle.
% The angles are assumed to be in radian.

%Yu Sang, Feb 28th 2019

strnVec = hpVec*AnPatLIGO_Fp(phi,theta,psi) + hcVec*AnPatLIGO_Fc(phi,theta,psi);
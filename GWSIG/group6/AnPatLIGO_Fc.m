function Fc_Ten = AnPatLIGO_Fc(phi,theta,psi)
% Antenna Patterns for LIGO
% Antenna Pattern function F_cross in an interferometer¡¯s local frame
% for input source direction and polarization angle.
% Fc = AnPatLIGO_Fc(phi,theta, psi)
% phi and theta is azimuthal and polar angle values respectively.
% The polar angle range is 0 (z-axis) to 180 (negative z-axis). 
% psi is the polarization angle.
% The angles are assumed to be in radian.

%Yu Sang, Feb 28th 2019


%% Detcor tensor
% vectors of arms X and Y in Dector frame
nX_Vec=[1,0,0];
nY_Vec=[0,1,0];

nZ_Vec=[0,0,1];

%Detector tensor
D_Ten= (nX_Vec'*nX_Vec - nY_Vec'*nY_Vec)*1/2;

%% Wave vector
% source direction
nSou_Vec = [sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta)];

%vectors of X and Y in Wave frame
nX_Wa_Vec = vcrossprod(nZ_Vec,nSou_Vec);
%normalize
nX_Wa_Vec = nX_Wa_Vec / norm(nX_Wa_Vec);
nY_Wa_Vec = vcrossprod(nX_Wa_Vec, nSou_Vec);

%rotating of X and Y according to the polarization angle.
nX_Wa_Vec_Rot =  nX_Wa_Vec*cos(psi) + nY_Wa_Vec*sin(psi);
nY_Wa_Vec_Rot = -nX_Wa_Vec*sin(psi) + nY_Wa_Vec*cos(psi);

%polarization tensors e_plus and e_cross
ep_Ten = nX_Wa_Vec_Rot'*nX_Wa_Vec_Rot - nY_Wa_Vec_Rot'*nY_Wa_Vec_Rot;
ec_Ten = nX_Wa_Vec_Rot'*nY_Wa_Vec_Rot + nY_Wa_Vec_Rot'*nX_Wa_Vec_Rot;

%% antenna pattern functions
Fp_Ten = sum(ep_Ten(:).*D_Ten(:));
Fp_Ten = abs(Fp_Ten);
Fc_Ten = sum(ec_Ten(:).*D_Ten(:));
Fc_Ten = abs(Fc_Ten);
%% Antenna Patterns for LIGO

%Yu Sang, Feb 28th 2019

function Fp_Ten = AnPatLIGO_Fp(phi,theta)


%% Detcor tensor
% vectors of arms X and Y in Dector frame
nX_Vec=[1,0,0];
nY_Vec=[0,1,0];

nZ_Vec=[0,0,1];

%Detector tensor
D_Ten= (nX_Vec'*nX_Vec - nY_Vec'*nY_Vec)*1/2;

%%Wave vector
% source direction
nSou_Vec = [sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta)];

%vectors of X and Y in Wave frame
nX_Wa_Vec = vcrossprod(nZ_Vec,nSou_Vec);
%normalize
nX_Wa_Vec = nX_Wa_Vec/norm(nX_Wa_Vec);
nY_Wa_Vec = vcrossprod(nX_Wa_Vec, nSou_Vec);

%polarization tensors
ep_Ten = nX_Wa_Vec'*nX_Wa_Vec - nY_Wa_Vec'*nY_Wa_Vec;
ec_Ten = nX_Wa_Vec'*nY_Wa_Vec + nY_Wa_Vec'*nX_Wa_Vec;

%antenna pattern functions
Fp_Ten = sum(ep_Ten(:).*D_Ten(:));
Fp_Ten = abs(Fp_Ten);
Fc_Ten = sum(ec_Ten(:).*D_Ten(:));
Fc_Ten = abs(Fc_Ten);
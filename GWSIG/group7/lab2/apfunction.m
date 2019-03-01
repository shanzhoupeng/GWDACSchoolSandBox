function [fplus,fcross]=apfunction(theta,phi,psi)
%Antenna pattern function
%[F+,Fx]=APFUNCTION(THETA,PHI,PSI)
%returns the values of antenna pattern functions F+ and Fx.
%THETA and PHI are azimuthal and polar angles respectively.
%PSI is the polarizatin angle.
%Note: THETA, PHI and PSI can not be a vectors.

%David Zhang, Feb 2019

%two unit vectors along arms of the detector
n1=[1 0 0];
n2=[0 1 0];

%detector tensor
dttensor=0.5*(n1'*n1-n2'*n2);

%axis basis of chirp signal
ex0=[-sin(phi) cos(phi) 0];
ey0=[cos(theta)*cos(phi) cos(theta)*sin(phi) -sin(theta)];

%axis basis of inspirals
ex=cos(psi)*ex0-sin(psi)*ey0;
ey=sin(psi)*ex0+cos(psi)*ey0;

%basis for polarization modes(tensors)
eplus=ex'*ex-ey'*ey;
ecross=ex'*ey+ey'*ex;

%contract to get antenna pattern functions
fplus=sum(dttensor(:).*eplus(:));
fcross=sum(dttensor(:).*ecross(:));





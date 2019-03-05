function strVec=genStrSig4StaInf(hplusVec,hcrossVec,theta,phi)
% strain signal generator
%S=GENSTRSIG4STAINF(H1,H2,THETA,PHI)
%returns a strain signal for a static interferometer.
%H1 and H2 are plorization functions for plus and cross mode respectively.
%THETA and PHI are azimuthal and polar angles respectively.
%Note: THETA, PHI and PSI can not be a vectors.
%      function "apfunction" should be added to the path

%David Zhang, Feb 2019

[fplus,fcross]=apfunction(theta,phi,0);
strVec=fplus*hplusVec+fcross*hcrossVec;
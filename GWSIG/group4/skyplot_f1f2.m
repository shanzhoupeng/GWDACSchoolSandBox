function [] = skyplot(alphaVec,deltaVec,fHandle1,fHandle2)
%Plot a function of sky angles on the unit sphere
%SKYPLOT(A,D,F1,F2)
%A and D are the vector of azimuthal and polar angle values respectively. F
%is the handle to the function (see below) of A and D that is to be plotted on the
%sphere. The polar angle range is 0 (z-axis) to 180 (negative z-axis). The
%angles are assumed to be in radian.
%
%Example:
% The function to be plotted is named 'fp' and accepts inputs 'theta' and
% 'phi'. Then,do:
% >> fhandle = @(x,y) fp(x,y)
% >> skyplot(0:0.1:(2*pi),0:0.1:pi, fhandle, fhandle);

%Soumya D. Mohanty, June 2018

%Generate the X, Y, Z meshes corresponding to the azimuthal and polar
%angles
[A,D] = meshgrid(alphaVec,deltaVec);
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);

%Generate function values
fVals1 = zeros(length(deltaVec),length(alphaVec));
fVals2 = zeros(length(deltaVec),length(alphaVec));
for lp1 = 1:length(alphaVec)
    for lp2 = 1:length(deltaVec)
        fVals1(lp2,lp1) = fHandle1(alphaVec(lp1),deltaVec(lp2));
        fVals2(lp2,lp1) = fHandle1(alphaVec(lp1),deltaVec(lp2));
    end
end

%Plot
subplot(1,2,1)
surf(X,Y,Z,abs(fVals1));
subplot(1,2,2)
surf(X,Y,Z,abs(fVals2));
shading interp;

function output=Fcross(phi,theta,angle)
% Calculate the Fcross
[unitx,unity]=calcUnits(phi,theta,angle);

ecross=unitx'*unity+unity'*unitx;

nx=[1,0,0];
ny=[0,1,0];
D=nx'*nx-ny'*ny;

output=sum(D(:).*ecross(:));

 

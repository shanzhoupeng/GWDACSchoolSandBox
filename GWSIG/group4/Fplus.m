function output=Fplus(phi,theta,angle)
% Calculate the Fplus.
[unitx,unity]=calcUnits(phi,theta,angle);

eplus=unitx'*unitx-unity'*unity;

nx=[1,0,0];
ny=[0,1,0];
D=nx'*nx-ny'*ny;

output=sum(D(:).*eplus(:));

 

function output=Fcross(phi,theta,angle)
unitr=[sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta)];
unity0=-[sin(phi),-cos(phi),0]; %~dr/dphi
unitx0=[cos(theta)*cos(phi),cos(theta)*sin(phi),-sin(theta)];%~dr/dtheta

unitx= unitx0*cos(angle)+unity0*sin(angle);
unity=-unitx0*sin(angle)+unity0*cos(angle);

eplus =unitx'*unitx-unity'*unity;
ecross=unitx'*unity+unity'*unitx;

nx=[1,0,0];
ny=[0,1,0];
D=nx'*nx-ny'*ny;

output=sum(D(:).*ecross(:));

 

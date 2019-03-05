function [Fp,Fc]=fpfc(x,y,psai)
    
the_bar=[cos(y)*cos(x),cos(y)*sin(x),-sin(y)];
phi_bar=-[sin(x),-cos(x),0];
% r_bar=[sin(x).*cos(y),sin(x).*sin(y),cos(y)];

%% polarization tensor
Ux=the_bar*cos(2*psai)+phi_bar*sin(2*psai);
Uy=-the_bar*sin(2*psai)+phi_bar*cos(2*psai);

Ep=Ux'*Ux-Uy'*Uy;
Ec=Ux'*Uy+Uy'*Ux;
%detctor vector
nx=[1,0,0];
ny=[0,1,0];

%% detector tensor
D=nx'*nx-ny'*ny;

Fp=sum(Ep(:).*D(:));
Fc=sum(Ec(:).*D(:));

function [hp,hx]=gwsig(phi,theta,rho)
% Get the h+, hx reflection for specific angle.
% [HP,HX]=GWSIG(P,T,R);
% 0<=phi<2*pi, 0<=theta<pi, 0<=rho<2*pi.

% Tai Zhou, Feb 2019
x0=[1,0,0];
y0=[0,1,0];
z0=[0,0,1];
r=[sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta)];
x1=cross(z0,r)/sin(theta);
y1=cross(x1,r);
x=cos(rho)*x1-sin(rho)*y1;
y=sin(rho)*x1+cos(rho)*y1;
hp=abs(abs(dot(x0,x))-abs(dot(y0,x))+abs(dot(y0,y))-abs(dot(x0,y)))/2;
xx=(x-y)./sqrt(2);
yx=(x+y)./sqrt(2);
hx=abs(abs(dot(x0,xx))-abs(dot(y0,xx))+abs(dot(y0,yx))-abs(dot(x0,yx)))/2;

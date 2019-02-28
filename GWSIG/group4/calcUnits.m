function [unitx,unity]= calcUnits(phi,theta,angle)
% Calculate the orthogonal unit vectors for the gravitational wave.
% Xiao Xue, group4, Feb 2019.
    unitr=[sin(theta)*cos(phi),sin(theta)*sin(phi),cos(theta)];
    unity0=-[sin(phi),-cos(phi),0]; %~dr/dphi
    unitx0=[cos(theta)*cos(phi),cos(theta)*sin(phi),-sin(theta)];%~dr/dtheta
% Rotate the orthogonal unit vectors.
    unitx= unitx0*cos(angle)+unity0*sin(angle);
    unity=-unitx0*sin(angle)+unity0*cos(angle);


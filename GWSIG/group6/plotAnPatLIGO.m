%% Plot Antenna Patterns for LIGO

%Yu Sang, Feb 28th 2019

% fhandle = @(x,y) AnPatLIGO_Fp(x,y,0)
% skyplot(0:0.02:(2*pi),0:0.02:pi, fhandle);

fhandle = @(x,y) AnPatLIGO_Fc(x,y,0)
skyplot(0:0.02:(2*pi),0:0.02:pi, fhandle);
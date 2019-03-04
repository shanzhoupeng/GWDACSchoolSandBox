%% Fplus
fhandle = @(x,y) 0.5*(1+cos(y)^2)*cos(2*x)
skyplot(0:0.1:(2*pi),0:0.1:pi, fhandle);
%% Fcross
fhandle = @(x,y) cos(y)*sin(2*x)
skyplot(0:0.1:(2*pi),0:0.1:pi, fhandle);

fhandle = @(x,y) AnPatLIGO_Fp(x,y)
skyplot(0:0.1:(2*pi),0:0.1:pi, fhandle);

% fhandle = @(x,y) AnPatLIGO_Fc(x,y)
% skyplot(0:0.1:(2*pi),0:0.1:pi, fhandle);
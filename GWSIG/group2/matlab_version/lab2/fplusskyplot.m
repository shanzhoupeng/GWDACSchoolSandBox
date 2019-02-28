%% Test SKYPLOT
alphaVec = 0:0.05:(2*pi);
deltaVec = 0:0.05:pi;

fHandle = @(x,y) Fplus(y, x, 0);

%Run skyplot
skyplot(alphaVec, deltaVec, fHandle);
axis equal;
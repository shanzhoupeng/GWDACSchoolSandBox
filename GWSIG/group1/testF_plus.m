%draw the skyplot of F_plus
clc;
fhandle1 = @(x,y) F_plus(x,y);
skyplot(0:0.01:(2*pi),0:0.01:pi, fhandle1);

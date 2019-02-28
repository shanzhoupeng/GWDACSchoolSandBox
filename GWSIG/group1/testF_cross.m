%draw the skyplot of F_cross
clc;
fhandle2 = @(x,y) F_cross(x,y)
skyplot(0:0.01:(2*pi),0:0.01:pi, fhandle2);
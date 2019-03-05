x = pi/16:pi/16:2*pi; 
v = zeros(1,length(x));

xq = 0:pi/4:2*pi;

figure
vq1 = interp1(x,v,xq);
plot(x,v,'o',xq,vq1,':.');
xlim([0 2*pi]);
title('(Default) Linear Interpolation');
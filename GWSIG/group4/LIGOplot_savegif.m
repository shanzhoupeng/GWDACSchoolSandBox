%% Modified Main Program.
%  the same output from LIGOplot.m, but films are saved as gif 
%  Xiaobo Zou, Feb 2019

%% gif 1
for i=1:100
   a=i/100*2*pi;
   Fp=@(x,y) Fplus(x,y,a);
   skyplot(0:0.1:2*pi+0.1,0:0.1:pi,Fp)
   title(sprintf('Fplus(psi=%f)',a));
     
frame=getframe(gcf);
imind=frame2im(frame);
[imind,cm] = rgb2ind(imind,20);

if i==1
    imwrite(imind,cm,'Fplus.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
else
    imwrite(imind,cm,'Fplus.gif','gif','WriteMode','append','DelayTime',1e-4);
end

end
    

%% gif 2
for i=1:100
   a=i/100*2*pi;
   Fp=@(x,y) Fcross(x,y,a);
   skyplot(0:0.1:2*pi+0.1,0:0.1:pi,Fp)
   title(sprintf('Fcross(psi=%f)',a));
     
frame=getframe(gcf);
imind=frame2im(frame);
[imind,cm] = rgb2ind(imind,20);

if i==1
    imwrite(imind,cm,'Fcross.gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
else
    imwrite(imind,cm,'Fcross.gif','gif','WriteMode','append','DelayTime',1e-4);
end

end







%{
figure();
for i=1:100
    a=i/100*2*pi;
    Fc=@(x,y) Fcross(x,y,a);
    skyplot(0:0.1:2*pi+0.1,0:0.1:pi,Fc)
    fmat2(:,i)=getframe; 
end
%}
%% to save as gif

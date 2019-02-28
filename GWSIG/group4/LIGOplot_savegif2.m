%% Modified Main Program.
%  the same output from LIGOplot.m, but films are saved as gif 
%  Xiaobo Zou, Feb 2019

%% gif 1
for i=1:100
   a=i/100*2*pi;
   Fp1=@(x,y) Fplus(x,y,a);
   Fp2=@(x,y) Fplus(x,y,a);
   skyplot_f1f2(0:0.1:2*pi+0.1,0:0.1:pi,Fp1,Fp2)
   title(sprintf('Fplus(psi=%f) , Fcross(psi=%f) ',a,a));
     
frame=getframe(gcf);
imind=frame2im(frame);
[imind,cm] = rgb2ind(imind,20);

if i==1
    imwrite(imind,cm,'Fplus(psi)-Fcross(psi).gif','gif', 'Loopcount',inf,'DelayTime',1e-4);
else
    imwrite(imind,cm,'Fplus(psi)-Fcross(psi).gif','gif','WriteMode','append','DelayTime',1e-4);
end

end
    


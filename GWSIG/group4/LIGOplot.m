figure
for i=1:100
    a=i/100*2*pi;
    Fp=@(x,y) Fplus(x,y,a);
    skyplot(0:0.1:2*pi+0.1,0:0.1:pi,Fp)
    fmat1(:,i)=getframe;
end
 figure
for i=1:100
    a=i/100*2*pi;
    Fc=@(x,y) Fcross(x,y,a);
    skyplot(0:0.1:2*pi+0.1,0:0.1:pi,Fc)
    fmat2(:,i)=getframe; 
end
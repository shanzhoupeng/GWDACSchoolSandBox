for i=1:100
    a=i/100*2*pi;
    skyplot_zhoutai(0:0.05:(2*pi),0:0.05:pi,a,@(x,y,z) gwsig(x,y,z));
    fmat(:,i)=getframe;
end
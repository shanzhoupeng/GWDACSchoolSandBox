%% Fp and Fc calculation for static and long wavelength approximation

alphaVec = 0:0.05:(2*pi)+0.05;
deltaVec = 0:0.05:pi+0.05;

figure
for i=1:100
    a=i/100*2*pi;
    Fc= @(x,y) fpfc(x,y,a);
    skyplot(alphaVec,deltaVec,Fc)
    fmat1(:,i)=getframe;
end

% figure
% for i=1:100
%     a=i/100*2*pi;
%     Fc= @(x,y) fpfc(x,y,a);
%     skyplot(alphaVec,deltaVec,Fc)
%     fmat1(:,i)=getframe;
% end
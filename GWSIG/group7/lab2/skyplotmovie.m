%% Plot antenna pattern functions for different polarization angles
%polarization angle varies with time

%Adapt from Soumya D. Mohanty's "skyplot"

%% 
nsample=101;

deltaVec=(0:pi/(nsample-1):pi);%thetaVec
alphaVec=(0:2*pi/(nsample-1):2*pi);%phiVec
fplusVec=zeros(1,nsample);
fcrossVec=zeros(1,nsample);

%% Variables about movie
nframe=20;%number of frames. not too large if your computer is not good enough
periodoftime=2;%second
fps=nframe/periodoftime;
nloops=1;%number of loops

fmatplus=moviein(nframe);
fmatcross=moviein(nframe);

%%
[A,D] = meshgrid(alphaVec,deltaVec);
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);


%% Get frames and store
for k=1:nframe;
%% Generate fplusVec and fcrossVec of every time(psi)
fValsplus = zeros(length(deltaVec),length(alphaVec));
fValscross = zeros(length(deltaVec),length(alphaVec));
psi=(k-1)*2*pi/nframe;
for lp1 = 1:length(alphaVec)
    for lp2 = 1:length(deltaVec)
        [fValsplus(lp2,lp1),fValscross(lp2,lp1)] = apfunction(deltaVec(lp2),alphaVec(lp1),psi);
    end
end
%% Get frames
set(gcf,'outerposition',get(0,'screensize'));
surf(X,Y,Z,abs(fValsplus));axis equal
shading interp;
fmatplus(:,k)=getframe;
surf(X,Y,Z,abs(fValscross));axis equal
shading interp;
fmatcross(:,k)=getframe;

end

%% Let's play the movie
figure
set(gcf,'outerposition',get(0,'screensize'));
movie(fmatplus,nloops,fps,[500,-233,0,0])

figure
set(gcf,'outerposition',get(0,'screensize'));
movie(fmatcross,nloops,fps,[500,-233,0,0])




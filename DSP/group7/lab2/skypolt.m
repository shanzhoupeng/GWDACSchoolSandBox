%% Plot antenna pattern functions
%
%Adapt from Soumya D. Mohanty's "skyplot"

%% 
nsample=101;
deltaVec=(0:pi/(nsample-1):pi);%thetaVec
alphaVec=(0:2*pi/(nsample-1):2*pi);%phiVec
fplusVec=zeros(1,nsample);
fcrossVec=zeros(1,nsample);


%%
[A,D] = meshgrid(alphaVec,deltaVec);
X = sin(D).*cos(A);
Y = sin(D).*sin(A);
Z = cos(D);

%% Generate fplusVec and fcrossVec
fValsplus = zeros(length(deltaVec),length(alphaVec));
fValscross = zeros(length(deltaVec),length(alphaVec));
for lp1 = 1:length(alphaVec)
    for lp2 = 1:length(deltaVec)
        [fValsplus(lp2,lp1),fValscross(lp2,lp1)] = apfunction(deltaVec(lp2),alphaVec(lp1),0);
    end
end

%% Plot
figure
surf(X,Y,Z,abs(fValsplus));axis equal
shading interp;
figure
surf(X,Y,Z,abs(fValscross));axis equal
shading interp;

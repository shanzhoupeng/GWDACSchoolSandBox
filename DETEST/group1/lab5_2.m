ffparams = struct('rmin',-5,'rmax',5);
fitFuncHandle = @(x) crcbpsotestfunc(x,ffparams);
%% Watch the surface plot
[Xgrid,Ygrid]=meshgrid(-1:0.01:1,-1:0.01:1);
Zgrid=Xgrid;
for i=1:length(Xgrid(:,1))
    for j= 1:length(Ygrid(1,:))
        [Zgrid(i,j),realcoord]=fitFuncHandle([Xgrid(i,j),Ygrid(i,j)]);
        Xgrid(i,j)=realcoord(1);
        Ygrid(i,j)=realcoord(2);
    end
end
figure;
surf(Xgrid,Ygrid,Zgrid);

%% See role of interation steps

for i=1:20
    Niter(i)=i*5;
    rng('default')
    psoOut = crcbpso(fitFuncHandle,2,struct('maxSteps',Niter(i)));
    bestFitVal(i)=psoOut.bestFitness;
end
figure;
plot(Niter,bestFitVal);
xlabel('Number of iterations');
ylabel('Best fitness');
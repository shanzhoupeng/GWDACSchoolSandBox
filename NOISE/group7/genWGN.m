%% Generate WGN
%%
nSamples=10000;
realization1=randn(1,nSamples);
realization2=2.*randn(1,nSamples);
realization3=sqrt(2).*randn(1,nSamples);
realization4=2+sqrt(2).*randn(1,nSamples);
%%
figure
hist(realization1,50);
figure
hist(realization2,50);
figure
hist(realization3,50);
figure
hist(realization4,50);

%%
mean1=mean(realization1);
mean2=mean(realization2);
mean3=mean(realization3);
mean4=mean(realization4);
std1=std(realization1);
std2=std(realization2);
std3=std(realization3);
std4=std(realization4);
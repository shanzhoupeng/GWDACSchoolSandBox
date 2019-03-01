%%generating WGN
Nsamples=10000;
%making required WGNs
WGN1=randn(1,Nsamples);
WGN2=randn(1,Nsamples)*2;
WGN3=randn(1,Nsamples)*sqrt(2);
WGN4=2+randn(1,Nsamples)*sqrt(2);

%drawing histograms
figure;
hist(WGN1);
figure;
hist(WGN2);
figure;
hist(WGN3);
figure;
hist(WGN4);

%estimating mean value and variances
mymean1=mean(WGN1);
mymean2=mean(WGN2);
mymean3=mean(WGN3);
mymean4=mean(WGN4);
mystd1=std(WGN1);
mystd2=std(WGN2);
mystd3=std(WGN3);
mystd4=std(WGN4);

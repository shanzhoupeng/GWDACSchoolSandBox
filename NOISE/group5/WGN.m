
%% WGN with \mu=0, \sigma=1
sample=10000;
mu=0;
sigma=1;
y=mu + sigma* randn(1,sample); 
figure(1);
plot(y)
ymin=min(y);
ymax=max(y);
%Divide the maximum and minimum intervals
%into 20 equal points (19 equal parts), and then
%calculate the number of each interval separately.
x=linspace(ymin,ymax,20);
yy=hist(y,x);
yy=yy/length(y);
figure(2)
bar(x,yy)%Draw a probability density distribution histogram

%% WGN with \mu=0, \sigma=2
sample=10000;
mu=0;
sigma=2;
y=mu + sigma* randn(1,sample); 
figure(1);
plot(y)
ymin=min(y);
ymax=max(y);
%Divide the maximum and minimum intervals
%into 20 equal points (19 equal parts), and then
%calculate the number of each interval separately.
x=linspace(ymin,ymax,20);
yy=hist(y,x);
yy=yy/length(y);
figure(2)
bar(x,yy)%Draw a probability density distribution histogram
%% WGN with \mu=0, \sigma=sqrt(2)
sample=10000;
mu=0;
sigma=sqrt(2);
y=mu + sigma* randn(1,sample); 
figure(1);
plot(y)
ymin=min(y);
ymax=max(y);
%Divide the maximum and minimum intervals
%into 20 equal points (19 equal parts), and then
%calculate the number of each interval separately.
x=linspace(ymin,ymax,20);
yy=hist(y,x);
yy=yy/length(y);
figure(2)
bar(x,yy)%Draw a probability density distribution histogram
%% WGN with \mu=0, \sigma=sqrt(2)
sample=10000;
mu=0;
sigma=sqrt(2);
y=mu + sigma* randn(1,sample); 
figure(1);
plot(y)
ymin=min(y);
ymax=max(y);
%Divide the maximum and minimum intervals
%into 20 equal points (19 equal parts), and then
%calculate the number of each interval separately.
x=linspace(ymin,ymax,20);
yy=hist(y,x);
yy=yy/length(y);
figure(2)
bar(x,yy)%Draw a probability density distribution histogram

%% WGN with \mu=2, \sigma=sqrt(2)
sample=10000;
mu=2;
sigma=sqrt(2);
y=mu + sigma* randn(1,sample); 
figure(1);
plot(y)
ymin=min(y);
ymax=max(y);
%Divide the maximum and minimum intervals
%into 20 equal points (19 equal parts), and then
%calculate the number of each interval separately.
x=linspace(ymin,ymax,20);
yy=hist(y,x);
yy=yy/length(y);
figure(2)
bar(x,yy)%Draw a probability density distribution histogram

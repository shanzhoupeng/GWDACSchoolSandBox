%% Play movies with higher fps
%% Load data that I have prestored
load('fmatplus.mat')
load('fmatcross.mat')

%% 
nframe=length(fmatplus);%number of frames. not too large if your computer is not good enough
periodoftime=2;%second
fps=nframe/periodoftime;
nloops=1;%number of loops

%% Plot
figure
set(gcf,'outerposition',get(0,'screensize'));
movie(fmatplus,nloops,fps,[500,-233,0,0])
figure
set(gcf,'outerposition',get(0,'screensize'));
movie(fmatcross,nloops,fps,[500,-233,0,0])
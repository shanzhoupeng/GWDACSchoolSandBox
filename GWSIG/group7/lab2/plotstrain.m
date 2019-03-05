%% Plot the strain signal for different parameters
%%
%Sampling frequency
sampFreq = 1024; %Hz
%Number of samples to generate
nSamples = 1024;
%Time samples
timeVec = (0:(nSamples-1))/sampFreq;

%% Parameters
A=1;
B=2;
theta=0;
freq=5;
phi0=pi/4;
%% Calculate hplus/cross
hplusVec=gensinusig(timeVec,A,freq,0);
hcrossVec=gensinusig(timeVec,B,freq,phi0);

%% Parameters of antenna pattern function
theta=0;
phi=0;
psi=0;

%% Get strainVec
[fplus,fcross]=apfunction(theta,phi,psi);
strainVec=fplus*hplusVec+fcross*hcrossVec;
%% Plot
plot(timeVec,strainVec)



%% General strain signal for a static interferometer

A = 10;
B = 5;
f0 = 100;
p0 = pi/4;

% Instantaneous frequency after 1 sec is 
maxFreq = f0;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples for 1 sec.
timeVec = 0:samplIntrvl:1.0;
% Number of samples
nSamples = length(timeVec);

% generate sinusoidal signal for h_plus and h_cross
hpVec = gensinsig(timeVec,A,f0,0);
hcVec = gensinsig(timeVec,B,f0,p0);

% generate strain signal
phi = pi/4;
theta = pi/6;
psi = 0;
strnVec = genStrnSig(hpVec, hcVec, phi,theta,psi);

% plot
figure;
hold on;
plot(timeVec,strnVec);

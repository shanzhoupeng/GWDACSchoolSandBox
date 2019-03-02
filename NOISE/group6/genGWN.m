%% Generating WGN
% White Gaussian Noise

% Yu Sang, Mar 1st 2019

% Number of samples to generate
nSamples = 10000;

% Number of bins for histogram plot
nBins = 50;

% The parameters for Gaussian distribution

% mu = 0;
% sigma = 1;
% mu = 0;
% sigma = 2;
% mu = 0;
% sigma = sqrt(2);
mu = 2;
sigma = sqrt(2);

% Generating WGN
WGNVec = mu + sigma*randn(1,nSamples);

% Plot histogram
histogram(WGNVec, nBins);

% mean and standard deviation of the samples
mean_WGN = mean(WGNVec)
std_WGN = std(WGNVec)

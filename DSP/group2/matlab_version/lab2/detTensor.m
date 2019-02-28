function result = detTensor(XBasis, YBasis)
% detector tensor 
% C = detTensor(X, Y)

% Zu-Cheng Chen, Feb 2019
result = 1/2 * (XBasis' * YBasis - YBasis' * YBasis);
end
function result = detTensor(XBasis, YBasis)
% detector tensor 
% C = detTensor(X, Y)

% Zu-Cheng Chen, Feb 2019
result = 1/2 * (XBasis' * XBasis - YBasis' * YBasis);
end
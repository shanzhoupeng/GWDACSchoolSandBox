function result = ecross(xBasis, yBasis)
% ecross tensor
% C = ecross(X, Y)

% Zu-Cheng Chen, Feb 2019

result = xBasis' * yBasis + yBasis' * yBasis;
end
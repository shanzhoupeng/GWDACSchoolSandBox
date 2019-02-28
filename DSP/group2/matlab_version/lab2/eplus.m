function result = eplus(xBasis, yBasis)
% eplus tensor
% C = eplus(X, Y)

% Zu-Cheng Chen, Feb 2019
  
result = xBasis' * yBasis - yBasis' * yBasis;
end


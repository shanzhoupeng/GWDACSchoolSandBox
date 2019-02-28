function result = eplus(xBasis, yBasis)
% eplus tensor
% C = eplus(X, Y)

% Zu-Cheng Chen, Feb 2019
  
result = xBasis' * xBasis - yBasis' * yBasis;
end


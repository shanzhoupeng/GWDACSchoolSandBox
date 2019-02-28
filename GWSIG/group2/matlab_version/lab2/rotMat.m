function result = rotMat(a)
% ruturn a 2 dimensional rataional matrix
% C = rotMat(A)

% Zu-Cheng Chen, Feb 2019
  
result = [cos(a) -sin(a) 0;
          sin(a) cos(a) 0;
          0 0 1];
end
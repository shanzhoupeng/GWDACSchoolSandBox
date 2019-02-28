function result = F_cross(phi, theta)
%Antenna pattern function(F_cross)
%R = F_PLUS(PHI, THETA)
%the antenna pattern functions (F_cross), phi, theta are sky angles

%Shucheng Yang, February 2019


%Detector Tensor 
n_x = [1, 0, 0];
n_y = [0, 1, 0];
D = 1/2 * ((n_x' * n_x) - (n_y' * n_y));

%Polarization Tensor
n = [sin(theta)* cos(phi), sin(theta)* sin(phi), cos(theta)];
n = n / norm(n);

Z = [0, 0, 1];

x_hat = vcrossprod(Z,n);
x_hat = x_hat / norm(x_hat);

y_hat = vcrossprod(x_hat,n);
y_hat = y_hat / norm(y_hat);

%e_cross
e_cross = x_hat' * y_hat + y_hat' * x_hat;

result = sum(D(:) .* e_cross(:));


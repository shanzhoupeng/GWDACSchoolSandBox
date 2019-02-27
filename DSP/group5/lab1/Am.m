% Revised by Group4, Feb 2019
function signal=Am(A,f,phi,t)%Group4: Changed AM->Am. Also the in the test function.
% Generate Amplitude modulated(AM) sinusoid signal
% S = AM(A,[f0,f1],phi,t)
% S==A*cos(2*pi*f0.*t).*sin(f1.*t+phi)
signal=A*cos(2*pi*f(2).*t).*sin(f(1).*t+phi);%Group4: Added ';'
end
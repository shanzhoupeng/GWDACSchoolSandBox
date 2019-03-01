%%Have a look at the noise spectrum

mynoise=load('iLIGOSensitivity.txt','-ascii');
loglog(mynoise(:,1),mynoise(:,2));
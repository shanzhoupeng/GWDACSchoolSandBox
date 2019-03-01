%%Try to set cutoffs in LIGO noise PSD

mynoise=load('iLIGOSensitivity.txt','-ascii');
semilogy(mynoise(:,1),mynoise(:,2),'o','displayname','original');%original sqrt PSD
hold on;

mynoise(1:40,2)=mynoise(41,2);%manually set lower cutoff
%mynoise(66:97,2)=-(mynoise(66,2)-mynoise(97,2))/(mynoise(66,1)-mynoise(97,1))*(mynoise(66:97,1)-mynoise(97,1)); 
mynoise(66:97,2)=mynoise(66,2);%manually set upper cutoff
semilogy(mynoise(:,1),mynoise(:,2)); %modified
legend('original','modified');

xlabel('Frequency (Hz)');
ylabel('\surd{S_n(f)}');
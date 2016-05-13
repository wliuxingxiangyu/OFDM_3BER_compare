%example_chow_algo
%--------------------------------------
%Programmed by xia
%2009年5月21日
%----------------------------------
N_subc=32;
BER=1e-4;
gap=-log(5*BER)/1.5; %in dB
P_av=1;
Pt=P_av*N_subc;
SNR_av=16;
noise=P_av./10.^(SNR_av./10);
Rt=128;
subcar_gains=random('rayleigh',1,1,N_subc);
SNR=(subcar_gains.^2)./(noise*gap); 
[bit_alloc power_alloc Iterate_count]=chow_algo(SNR,N_subc,gap,Rt);
bit_alloc
power_alloc=Pt.*(power_alloc./sum(power_alloc))
%*************************plot********************
figure(1);
subplot(2,1,1);
plot(subcar_gains,'-r');
legend('信道增益');
hold on;
stem(bit_alloc,'fill','MarkerSize',3);
% stairs(bit_alloc);
title('Chow算法');
ylabel('Bits allocation');
xlabel('Subcarriers');
axis([0 32 0 6]);
subplot(2,1,2);
stem(power_alloc,'fill','MarkerSize',3);
%stairs(power_alloc);
ylabel('Power allocation');
xlabel('Subcarriers');
% subplot(1,3,3);
% stem(x,SNR);
% T=sum(power_alloc)
axis([0 32 0 2]);



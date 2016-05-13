%---------------------Demo Algo-------------
%Programmed by xia
%09-05-28
%-------------------------------------
N_subc=32;
BER=1e-4;
gap=-log(5*BER)/1.5; %in dB
P_av=1;
Pt=P_av*N_subc;
Rt=128;
noise=P_av./10.^(SNR_av./10);
gain_subc=random('rayleigh',1,1,N_subc);
[bit_alloc power_alloc]=Fischer(N_subc,Rt,Pt,gain_subc);
bit_alloc
power_alloc=Pt.*(power_alloc./sum(power_alloc))
%------------------plot------------------------------
clf;
figure(1);
subplot(2,1,1);
plot(gain_subc,'-r');
legend('信道增益');
hold on;
stem(bit_alloc,'fill','MarkerSize',3);
title('Fischer算法');
ylabel('Bits allocation');
xlabel('Subcarriers');
axis([0 32 0 6]);
subplot(2,1,2);
stem(power_alloc,'fill','MarkerSize',3);
ylabel('Power allocation');
xlabel('Subcarriers');
%-----------------EOF----------------------------
axis([0 32 0 2]);

%Hughes-Hartogs Algorithm Demo
%--------------------------------
%Programmed by Xia zhaokang 
%May-22-2009
%-------------------------
N_subc=32;
P_av=1;
Pt=P_av*N_subc;
SNR_av=0;
Noise=P_av./10.^(SNR_av./10);
B=1e6;
N_psd=Noise./(B/N_subc);
BER=1e-4;
M=8;
Rb=128;
H=random('rayleigh',1,1,N_subc);
%--------------------------------------
[bit_alloc, power_alloc]=Hughes_Hartogs(N_subc,Rb,M,BER,N_psd,H);
bit_alloc
power_alloc=Pt.*(power_alloc./sum(power_alloc))
%--------------------------------------
clf;
figure(1);
subplot(2,1,1);
stem(bit_alloc,'fill','MarkerSize',3);
hold on;
plot(H,'-r');
ylabel('Bits allocation');
xlabel('Subcarriers');
title('Hughes-Hartogs Algorithm');
axis([0 32 0 6]);
subplot(2,1,2);
stem(power_alloc,'fill','MarkerSize',3);
% hold on;
% plot(H,'-r');
ylabel('Power allocation');
xlabel('Subcarriers');
axis([0 32 0 4]);
%--------------------------------
% figure(2);
% subplot(3,1,1);
% plot(H,'-r');
% subplot(3,1,2);
% stem(bit_alloc,'fill','MarkerSize',3);
% subplot(3,1,3);
% stem(power_alloc,'fill','MarkerSize',3);
% ylabel('power allocation');
% xlabel('subcarriers');
% grid on;











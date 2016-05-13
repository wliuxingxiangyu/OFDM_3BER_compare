%---------------------------3种算法综合比较---------------------------
N_subc=32;
BER=1e-4;
gap=-log(5*BER)/1.5; %in dB
P_av=1;
Pt=P_av*N_subc;
SNR_av=16;
noise=P_av./10.^(SNR_av./10);
Rt=128;
gain_subc=random('rayleigh',1,1,N_subc);
SNR=(gain_subc.^2)./(noise*gap); 
M=8;
%-----------------------------------------------------------------------
[bit_alloc1,power_alloc1]=Hughes_Hartogs(N_subc,Rt,M,BER,noise,gain_subc);
[bit_alloc2 power_alloc2 Iterate_count]=chow_algo(SNR,N_subc,gap,Rt);
[bit_alloc3 power_alloc3]=Fischer(N_subc,Rt,Pt,gain_subc);
bit_alloc1
bit_alloc2
bit_alloc3
power_alloc1=Pt.*(power_alloc1./sum(power_alloc1))
power_alloc2=Pt.*(power_alloc2./sum(power_alloc2))
power_alloc3
%*************************plot********************
figure(1);
subplot(4,1,1);
plot(gain_subc,'-r');
ylabel('Channel Gain');
title('信道增益');
axis([0 32 0 10]);
subplot(4,1,2);
stairs(bit_alloc1);%stairs(bit_alloc1,'fill','MarkerSize',3);
ylabel('Bits');
title('Hughes-Hartogs算法');
axis([0 32 0 10]);
subplot(4,1,3);
stairs(bit_alloc2);%stairs(bit_alloc2,'fill','MarkerSize',3);
ylabel('Bits');
title('Chow算法');
axis([0 32 0 10]);
subplot(4,1,4);
stairs(bit_alloc3);%stairs(bit_alloc3,'fill','MarkerSize',3);
ylabel('Bits');
title('Fischer算法');
xlabel('Subcarriers');
axis([0 32 0 10]);
%-------------------------------------------------
% figure(2);
% subplot(4,1,1);
% plot(gain_subc,'-r');
% ylabel('Channel Gain');
% title('信道增益');
% subplot(4,1,2);
% stem(bit_alloc1,'fill','MarkerSize',3);
% ylabel('Bits');
% title('Hughes_Hartogs算法');
% subplot(4,1,3);
% stem(bit_alloc2,'fill','MarkerSize',3);
% ylabel('Bits');
% title('Chow算法');
% subplot(4,1,4);
% stem(bit_alloc3,'fill','MarkerSize',3);
% ylabel('Bits');
% title('Fischer算法');
% xlabel('Subcarriers');
%---------------------------------------------
% figure(3);
% subplot(4,1,1);
% plot(gain_subc,'-r');
% ylabel('Channel Gain');
% title('信道增益');
% subplot(4,1,2);
% stem(power_alloc1,'fill','MarkerSize',3);
% ylabel('Power');
% title('Hughes_Hartogs算法');
% subplot(4,1,3);
% stem(power_alloc2,'fill','MarkerSize',3);
% ylabel('Power');
% title('Chow算法');
% subplot(4,1,4);
% stem(power_alloc3,'fill','MarkerSize',3);
% ylabel('Power');
% title('Fischer算法');
% xlabel('Subcarriers');
%-------------------------------------------------
figure(2);
subplot(4,1,1);
plot(gain_subc,'-r');
ylabel('Channel Gain');
title('信道增益');
axis([0 32 0 4]);
subplot(4,1,2);
stairs(power_alloc1);
ylabel('Power');
title('Hughes-Hartogs算法');
axis([0 32 0 2]);
subplot(4,1,3);
stairs(power_alloc2);
ylabel('Power');
title('Chow算法');
axis([0 32 0 2]);
subplot(4,1,4);
stairs(power_alloc3);
ylabel('Power');
xlabel('Subcarriers');
title('Fischer算法');
% subplot(2,1,2);
% stem(power_alloc,'fill','MarkerSize',3);
% ylabel('Power allocation');
% xlabel('Subcarriers');
% subplot(1,3,3);
% stem(x,SNR);
% T=sum(power_alloc)
axis([0 32 0 8]);


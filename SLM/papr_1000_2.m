%SLM 方法的PAPR与原始PAPR
clear all;
close all;
 K=64;
 n1=1000; 
 Fs=100;
 M=16;
 
 for i=1:n1; 
 x(:,1)=randsrc(K,1,[+1 -1 +3 -3]);
 x(:,2)=randsrc(K,1,[+1 -1 +3 -3]);
 y1=squeeze(x);
a=amodce(y1,Fs,'qam');    %qam modulated information
y2=a.';
z1=[y2(1:K/2),zeros(1,3*K),y2(K/2+1:K)];
w1=ifft(z1);
w1=w1*K;
x1=(abs(w1)).^2;
m1=mean(x1);
v1=max(x1);
papr0(i)=10*log10(v1/m1);

for k=1:M;    %slm的循环次数
 p=randsrc(1,K,[+1,-1,+j,-j]);
 y3=y2.*p;
z2=[y3(1:K/2),zeros(1,3*K),y3(K/2+1:K)]; 
 w2=ifft(z2);
w2=w2*K;
x2=(abs(w2)).^2;
m2=mean(x2);
v2=max(x2);
papr3(i,k)=10*log10(v2/m2);
papr1(k)=10*log10(v2/m2);
end

papr16(i)=min(papr1);

end
x=1:1:1000;

%  title('OFDM系统与CSLM-OFDM系统PAPR比较','fontsize',14)
%  legend('\fontsize{14}OFDM','16CSLM-OFDM')

[papr0_max,papr0i_max]=max(papr0);
[papr16_max,papr16i_max]=max(papr16);
% textpapr0i=num2str(papr0i_max);
textpapr0=num2str(papr0_max);
% textpapr16i=num2str(papr16i_max);
textpapr16=num2str(papr16_max);
max_text0=strcat('最大值',textpapr0);
max_text16=strcat('最大值',textpapr16);

[papr0_min,papr0i_min]=min(papr0);
[papr16_min,papr16i_min]=min(papr16);
textpapr00=num2str(papr0_min);
textpapr160=num2str(papr16_min);
min_text0=strcat('最小值',textpapr00);
min_text16=strcat('最小值',textpapr160);




subplot(2,1,1);
plot(x,papr0,'-')
xlabel('OFDM符号序号','fontsize',14)
 title('OFDM系统PAPR','fontsize',14)
ylabel('PAPR(dB)','fontsize',14);
text(papr0i_max+0.2,papr0_max+0.3,max_text0);
text(papr0i_min-0.2,papr0_min-0.3,min_text0);
axis([0 1000 4 12]);

subplot(2,1,2);
plot(x,papr16,'-')
ylabel('PAPR(dB)','fontsize',14);
xlabel('OFDM符号序号','fontsize',14)
title('CSLM-OFDM系统PAPR','fontsize',14)
axis([0 1000 4 8]);
text(papr16i_max+0.2,papr16_max+0.1,max_text16);
text(papr16i_min-0.2,papr16_min-0.1,min_text16);
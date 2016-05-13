%PAPR����ֵslM����
clear all;
close all;
N1=64;
N=4*N1;
z = 1:.2:15;
y1 = (1-(1-exp(-z)).^N);
y2 = (1-(1-exp(-z)).^N).^2;
y3 = (1-(1-exp(-z)).^N).^4;
y4 = (1-(1-exp(-z)).^N).^8;
y5 = (1-(1-exp(-z)).^N).^16;
semilogy(z,y1,'-+k',z,y2,'-*k',z,y3,'-ok',z,y4,'-vk',z,y5,'-.k')
axis([1  16  1e-4  1])
xlabel('PAPR0/dB')
ylabel('CCDF')
title('��ͬѡ������M��OFDMѡ����ӳ�䷽��PAPR');
legend('OFDMԭʼ�ź�','M=2','M=4','M=8','M=16')
% grid on

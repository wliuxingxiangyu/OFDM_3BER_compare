clc;clear;close all;
a=xlsread('E:/pic/SNR_BER_4curve.xls');
xs8O=a(:,1);%800 OFDM��
ys8O=a(:,2);
%��3�пճ�
xs8R=a(:,4);%800 RAADA��
ys8R=a(:,5);
%��6�пճ�
xs4O=a(:,7);%400  OFDM��
ys4O=a(:,8);
%��9�пճ�
xs4R=a(:,10);%800  RAADA��
ys4R=a(:,11);
semilogy(xs8O,ys8O,'k-');%800 OFDM��ʵ��%semilogy�Եڶ�������ys75ȡlog.
hold on;
semilogy(xs8R,ys8R,'k:o');%800 RAADA������
hold on;
semilogy(xs4O,ys4O,'k--');%400  OFDM�������߽ϳ�
hold on;
semilogy(xs4R,ys4R,'k:.');%800  RAADA���㻮��

grid on;
% set(gca,'XTick',2:2:30);
legend('800km/h  OFDM','800km/h  RAADA','400km/h  OFDM','400km/h  RAADA');
xlabel('SNR(dB)');
ylabel('BER');
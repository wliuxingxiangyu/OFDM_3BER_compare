clc;clear;close all;
% a=xlsread('E:/pic/SNR_BER_4curve.xls');
a=xlsread('./SNR_BER_4curve.xls');
xs8O=a(:,1);%800 OFDM，
ys8O=a(:,2);
%第3列空出
xs8R=a(:,4);%800 RAADA，
ys8R=a(:,5);
%第6列空出
xs4O=a(:,7);%400  OFDM，
ys4O=a(:,8);
%第9列空出
xs4R=a(:,10);%800  RAADA，
ys4R=a(:,11);
semilogy(xs8O,ys8O,'k:*');%800 OFDM，实线%semilogy对第二个参数ys75取log.
hold on;
semilogy(xs8R,ys8R,'k:o');%800 RAADA，空心圆(中间的冒号一般都要，表示用虚线相连)
hold on;
semilogy(xs4O,ys4O,'k:v');%400  OFDM，下三角形
hold on;
semilogy(xs4R,ys4R,'k:.');%800  RAADA，点划线

grid on;
% set(gca,'XTick',2:2:30);
legend('800km/h  OFDM','800km/h  RAADA','400km/h  OFDM','400km/h  RAADA',0);
xlabel('SNR(dB)');
ylabel('BER');
axis([0 30  0.000001   1 ]);

%800km/h的改善百分比
ysOFDM_ysRAADA_800=ys8O-ys8R;
ysOFDM_ysRAADA_percent_800=(ysOFDM_ysRAADA_800/ys8O)*100;
ysOFDM_ysRAADA_percent_800min=min(ysOFDM_ysRAADA_percent_800)%  0.2292%
ysOFDM_ysRAADA_percent_800max=max(ysOFDM_ysRAADA_percent_800)% 33.3333% 

%400km/h的改善百分比
ysOFDM_ysRAADA_400=ys4O-ys4R;
ysOFDM_ysRAADA_percent_400=(ysOFDM_ysRAADA_400/ys4O)*100;
ysOFDM_ysRAADA_percent_400min=min(ysOFDM_ysRAADA_percent_400)%  16.6667%
ysOFDM_ysRAADA_percent_400max=max(ysOFDM_ysRAADA_percent_400)%  33.3333%


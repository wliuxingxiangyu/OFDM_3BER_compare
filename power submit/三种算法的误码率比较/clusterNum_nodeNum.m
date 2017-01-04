clc;clear;close all;
a=xlsread('./clusterNum_nodeNum.xlsx');
xsPerAOW=a(:,1);%
ysPerAOW=a(:,2);
plot(xsPerAOW,ysPerAOW,'k:o');
hold on

xsAOW=a(:,4);%
ysAOW=a(:,5);
plot(xsAOW,ysAOW,'k:v');

grid on;

legend('PerAOW','AOW',0);
xlabel('节点总数');
ylabel('簇的个数');
% set(gca,'XTick',0:10:150);
% set(gca,'yTick',0:1:15);
axis([0 150  0   15 ]);
clc;clear;
a=xlsread('E:/pic/8negative.xls');
xs75=a(:,1);
ys75=a(:,2);
%��3�пճ�
xs05=a(:,4);
ys05=a(:,5);
%��6�пճ�
xs025=a(:,7);
ys025=a(:,8);
%��9�пճ�
xs01=a(:,10);
ys01=a(:,11);
%��12�пճ�--�±�s��ʾ�ź�single��i��ʾ�źŸ���interfence---------------
xi75=a(:,13);
yi75=a(:,14);
%��15�пճ�
xi05=a(:,16);
yi05=a(:,17);
%��18�пճ�
xi025=a(:,19);
yi025=a(:,20);
%��21�пճ�
xi01=a(:,22);
yi01=a(:,23);
% plot(x,y,'>','MarkerSize',0.5);
plot(xs75,ys75,'k-');%ʵ��
hold on;
plot(xs05,ys05,'k:');%����
hold on;
plot(xs025,ys025,'k--');%�����߽ϳ�
hold on;
plot(xs01,ys01,'k:.');%�㻮��
% grid on;
plot(xi75,yi75,'k-');%ʵ��
hold on;
plot(xi05,yi05,'k:');%����
hold on;
plot(xi025,yi025,'k--');%�����߽ϳ�
hold on;
plot(xi01,yi01,'k:.');%�㻮��
axis([0 1  -0.1  1]);

line([0 1],[0,0],'color','k');%x1=0,y1=0,��x2=1,y2=0,yzһֱ��0���߼�y=0
line([0.75 0.75],[-0.1, 1],'color','k');%���߼�x=0.8
line([0.85 0.85],[-0.1, 1],'color','k');%���߼�x=0.85

xlabel('��һ����ΪƵ��f_{a}T_{s}');
ylabel('�����ϵ�� p');
% legend('HH  F_{D}T=0.75', '',  '',  ''); 
% legend('II F_{D}T=0.75','','','','');

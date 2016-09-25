clc;clear;
a=xlsread('E:/pic/8negative.xls');
xs75=a(:,1);
ys75=a(:,2);
%第3列空出
xs05=a(:,4);
ys05=a(:,5);
%第6列空出
xs025=a(:,7);
ys025=a(:,8);
%第9列空出
xs01=a(:,10);
ys01=a(:,11);
%第12列空出--下标s表示信号single，i表示信号干扰interfence---------------
xi75=a(:,13);
yi75=a(:,14);
%第15列空出
xi05=a(:,16);
yi05=a(:,17);
%第18列空出
xi025=a(:,19);
yi025=a(:,20);
%第21列空出
xi01=a(:,22);
yi01=a(:,23);
% plot(x,y,'>','MarkerSize',0.5);
plot(xs75,ys75,'k-');%实线
hold on;
plot(xs05,ys05,'k:');%虚线
hold on;
plot(xs025,ys025,'k--');%比虚线较长
hold on;
plot(xs01,ys01,'k:.');%点划线
% grid on;
plot(xi75,yi75,'k-');%实线
hold on;
plot(xi05,yi05,'k:');%虚线
hold on;
plot(xi025,yi025,'k--');%比虚线较长
hold on;
plot(xi01,yi01,'k:.');%点划线
axis([0 1  -0.1  1]);

line([0 1],[0,0],'color','k');%x1=0,y1=0,与x2=1,y2=0,yz一直是0连线即y=0
line([0.75 0.75],[-0.1, 1],'color','k');%连线即x=0.8
line([0.85 0.85],[-0.1, 1],'color','k');%连线即x=0.85

xlabel('归一化人为频移f_{a}T_{s}');
ylabel('互相关系数 p');
% legend('HH  F_{D}T=0.75', '',  '',  ''); 
% legend('II F_{D}T=0.75','','','','');

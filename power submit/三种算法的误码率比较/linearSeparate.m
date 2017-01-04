clc;clear;close all;
x0=0;y0=0;
r1=1;r2=2;
alpha=0:pi/50:2*pi;
x1=x0+r1*cos(alpha);
y1=y0+r1*sin(alpha);

x2=x0+r2*cos(alpha);
y2=y0+r2*sin(alpha);

size=size(alpha,2);

figure
for i=1:size
    plot(x1(i),y1(i),'k:.');
    hold on
    plot(x2(i),y2(i),'r:.');
end
grid on


figure
for i=1:size
    plot3(x1(i),y1(i),0,'k:.');
    hold on
    plot3(x2(i),y2(i),3,'r:.');
end
grid on


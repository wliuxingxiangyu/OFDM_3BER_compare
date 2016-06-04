clear all;clc;
N=256;
% xMax=(fdp-ftq)Ts=(20M-10M)*(0.5ms/7)
xMax=(20-10)*10^6*( 0.5*10^(-3)/7 )
%  x=-xMax:10:xMax;
 index=1;
for val=-xMax:10:xMax;
    xArr(index)=val;
    yArr(index)=sin(N*pi*val)/sin(pi*val);
    zArr(index)=yArr(index)*yArr(index);
    index=index+1;
end    
% plot(xArr,yArr,'-b');
% hold on;
% plot(xArr,zArr,'-k');
plot(xArr,yArr,xArr,zArr);
grid on;
% axis([-3,3,-2,6]);
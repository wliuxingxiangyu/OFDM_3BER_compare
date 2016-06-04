clc;clear;
fun='power(sin(256*t)./sin(t),2)' ,'t';
a=0.1;
index=1;
xArr=0.05:0.05:0.95;
for  index =1: size(xArr,2)
    xMax=pi*( a-xArr(index) );
    xMin=pi*( -a -xArr(index));
    pArr(index)=quad( fun,xMin,xMax   )%快--按点模拟函数
end
pArrMax=max(pArr);
for  index =1: size(xArr,2)
    pYaxis(index)=pArr(index)/pArrMax;
end
figure (1)
plot(xArr,pYaxis);
pYaxis
grid on;
%------------
% hold on
% t=0.05:0.05:0.95;
% yt=power(sin(256*t)./sin(t),2);
% plot(t,yt);


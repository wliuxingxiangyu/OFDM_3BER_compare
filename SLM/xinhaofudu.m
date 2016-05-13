%一个OFDM信号周期内经过IFFT后的信号幅度
clear all;
close all;
 K=128;
 Fs=100;
 
 x(:,1)=randsrc(K,1,[+1 -1 +3 -3]);
 x(:,2)=randsrc(K,1,[+1 -1 +3 -3]);
 y1=squeeze(x);
a=amodce(y1,Fs,'qam');    %qam modulated information
y2=a.';
z1=[y2(1:K/2),zeros(1,3*K),y2(K/2+1:K)];
w1=ifft(z1);
w1=w1*K*4;
x1=abs(w1);

n=[1:1:512];

 plot(n,x1)
 axis([1 512 0 80])



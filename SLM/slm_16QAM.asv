%SLM 方法的CCDF
clear all;
close all;
 K=512;%数据长度
 n1=2000; 
 Fs=100;
 M=16;
 
 for i=1:n1; 
     n1
 x(:,1)=randsrc(K,1,[+1 -1 +3 -3]);
 x(:,2)=randsrc(K,1,[+1 -1 +3 -3]);
 y1=squeeze(x);
a=amodce(y1,Fs,'qam');    %qam modulated information
y2=a.';
z1=[y2(1:K/2),zeros(1,4*K),y2(K/2+1:K)];
w1=ifft(z1);
w1=w1*K;
x1=(abs(w1)).^2;
m1=mean(x1);
v1=max(x1);
papr0(i)=10*log10(v1/m1);

for m=1:M;    %slm的循环次数
 p=randsrc(1,K,[+1,-1,+j,-j]);
 y3=y2.*p;
z2=[y3(1:K/2),zeros(1,4*K),y3(K/2+1:K)]; 
 w2=ifft(z2);
w2=w2*K;
x2=(abs(w2)).^2;
m2=mean(x2);
v2=max(x2);
papr3(i,m)=10*log10(v2/m2);
papr1(m)=10*log10(v2/m2);
end

papr2i= papr1(1:2);
papr2(i)=min(papr2i);
papr4i= papr1(1:4);
papr4(i)=min(papr4i);
papr8i= papr1(1:8);
papr8(i)=min(papr8i);
papr16(i)=min(papr1);

end



[m0 x1] = hist(papr0,[1:0.1:18]);
y1=1-cumsum(m0)/n1;


[m1 x2] = hist(papr2,[1:0.1:18]);
y2=1-cumsum(m1)/n1;

[m2 x3] = hist(papr4,[1:0.1:18]);
y3=1-cumsum(m2)/n1;

[m3 x4] = hist(papr8,[1:0.1:18]);
y4=1-cumsum(m3)/n1;

[m4 x5] = hist(papr16,[1:0.1:18]);
y5=1-cumsum(m4)/n1;

 semilogy(x1,y1,'-k',x2,y2,'-*k',x3,y3,'-.k',x4,y4,'-ok',x5,y5,'-vk')
 title('16QAM星座映射的SLM方法的CCDF曲线')
 xlabel('\fontsize{12} papr(dB)'),ylabel('\fontsize{12} ccdf')
 legend('原始值','M=2','M=4','M=8','M=16')
%  axis([1 12 0.0001 1])
 
%  data = [x1; y1];
%  save y1_c_512.am data -ascii;
%  data = [x2; y2];
%  save y2_c_512.am data -ascii;
%  data = [x3; y3];
%  save y3_c_512.am data -ascii;
%  data = [x4; y4];
%  save y4_c_512.am data -ascii;
%  data = [x5; y5];
%  save y5_c_512.am data -ascii;
 axis([6 12 0.001 1]);
 
 %y1_c_o  无过采样，非SLM； y2_c_o   无过采样，M＝2；     y3_c_o  无过采样，M＝4；
 %y3_c_o  无过采样，M＝8；  y4_c_o   无过采样，M＝16。
 
 
 %y1_c_o1 1倍过采样，非SLM； y2_c_o1  1倍过采样，M＝2；     y3_c_o1  1倍过采样，M＝4；
 %y3_c_o1 1倍过采样，M＝8；  y4_c_o1  1倍过采样，M＝16。
 
 
 %y1_c_o2  2倍过采样，非SLM； y2_c_o2  2倍过采样，M＝2；    y3_c_o2  2倍过采样，M＝4；
 %y3_c_o2  2倍过采样，M＝8；  y4_c_o2  2倍过采样，M＝16。

 
 %y1_c_o4  4倍过采样，非SLM； y2_c_o4  4倍过采样，M＝2；    y3_c_o4  4倍过采样，M＝4；
 %y3_c_o4  4倍过采样，M＝8；  y4_c_o4  4倍过采样，M＝16。
 
 
 %y1_c_o8  8倍过采样，非SLM； y2_c_o8  8倍过采样，M＝2；    y3_c_o8  8倍过采样，M＝4；
 %y3_c_o8  8倍过采样，M＝8；  y4_c_o8  8倍过采样，M＝16。
 
 
clear all; clc; close all;

K = 128;                                                                     % SIZE OF FFT 
V = 4;                                                                       % NUMBER OF SELECTIONS
QPSK_Set  = [1 -1 j -j];
Phase_Set = [1 -1];

Choose = [1 1 1 1; 1 1 1 2; 1 1 2 1; 1 2 1 1; 2 1 1 1;...
          1 1 2 2; 1 2 1 2; 1 2 2 1; 2 2 1 1; 2 1 2 1; 2 1 1 2;...      
          2 2 2 1; 2 2 1 2; 2 1 2 2; 1 2 2 2; 2 2 2 2];
Choose_Len = 16;      

MAX_SYMBOLS  = 1e4;%1e5
PAPR_Orignal = zeros(1,MAX_SYMBOLS);

%  original
for nSymbol=1:MAX_SYMBOLS
    Index = randint(1,K,length(QPSK_Set))+1;%1*128           randint（m,n,k）,随机产生m行n列的矩阵，矩阵值的范围是0~k-1。这里面后面加了1，产生的是从1~4的数，
    X= QPSK_Set(Index(1,:));                % Orignal Frequency domain signal        从QPSK_set中随机选取128个数作为用来调成OFDM信号的原信号。
    x = ifft(X,[],2);         %1*128      % Time domain signal   []是只按照X的实际点数来计算ifft，2是指返回的数据以2维数组的形式存放，这里可以省略        
    Signal_Power0 = abs(x.^2);
    Peak_Power0   = max(Signal_Power0,[],2);
    Mean_Power0   = mean(Signal_Power0,2);
    PAPR_Orignal(nSymbol) = 10*log10(Peak_Power0./Mean_Power0);
     
end



%随机分割＋遍历搜索

PAPR_PTS4 = zeros(1,MAX_SYMBOLS);
for nSymbol=1:MAX_SYMBOLS
    Index4 = randint(1,K,length(QPSK_Set))+1;
    X4 = QPSK_Set(Index4(1,:));                                               % Orignal Frequency domain signal
    l4=length(X4);
    A4= zeros(V,K);
    pilot4=randperm(l4);
    for k=1:V 
      A4(k,pilot4(k:V:l4))=X4(pilot4(k:V:l4));%随机
    end
    a4= ifft(A4,[],2);
    min_value4 = 10;
    for n4=1:Choose_Len
        temp_phase4= Phase_Set(Choose(n4,:)).';
        temp_max4= max(abs(sum(a4.*repmat(temp_phase4,1,K))));
         if temp_max4<min_value4
            min_value4= temp_max4;
            Best_n4 = n4;
        end
    end
    aa4= sum(a4.*repmat(Phase_Set(Choose(Best_n4,:)).',1,K));
    Signal_Power4= abs(aa4.^2);
    Peak_Power4= max(Signal_Power4,[],2);
    Mean_Power4 = mean(Signal_Power4,2);
    PAPR_PTS4(nSymbol) = 10*log10(Peak_Power4./Mean_Power4);
end 
  
   
   
%    相邻分割＋遍历搜索
   
   
   PAPR_PTS5= zeros(1,MAX_SYMBOLS);
for nSymbol=1:MAX_SYMBOLS
    Index5= randint(1,K,length(QPSK_Set))+1;
    X5= QPSK_Set(Index5(1,:));                                               % Orignal Frequency domain signal
    l5=length(X5);
    A5 = zeros(V,K);
    pilot5=randperm(l5);                                                     %产生元素是1到15的矩阵，各元素位置是随机的
    for k5=1:V 
       A5(k5,:) =[zeros(1,(k5-1)*l5/V),X5((k5-1)*l5/V+1:k5*l5/V),zeros(1,(V-k5)*l5/V)]; %相邻
    end
    a5 = ifft(A5,[],2);
    min_value5= 10;
    for n5=1:Choose_Len
        temp_phase5= Phase_Set(Choose(n5,:)).';
        temp_max5= max(abs(sum(a5.*repmat(temp_phase5,1,K))));
        if temp_max5<min_value5
            min_value5 = temp_max5;
            Best_n5 = n5;
        end

    end
    aa5 = sum(a5.*repmat(Phase_Set(Choose(Best_n5,:)).',1,K));
    Signal_Power5= abs(aa5.^2);
    Peak_Power5= max(Signal_Power5,[],2);
    Mean_Power5= mean(Signal_Power5,2);
    PAPR_PTS5(nSymbol) = 10*log10(Peak_Power5./Mean_Power5);
end 
 
   
   %交织分割＋遍历搜索
    PAPR_PTS6= zeros(1,MAX_SYMBOLS);
   for nSymbol=1:MAX_SYMBOLS
    Index6 = randint(1,K,length(QPSK_Set))+1;%1*128   % Orignal Frequency domain signal
    X6= QPSK_Set(Index6(1,:));       %1*128                                      
    x6= ifft(X6,[],2);  % Time domain signal
    l6=length(X6);
    A6= zeros(V,K);
    for v=1:V
        A6(v,v:V:K) = X6(v:V:K);%交织
    end
    a6= ifft(A6,[],2);
    min_value6= 10;
    for n6=1:Choose_Len
        temp_phase6= Phase_Set(Choose(n6,:)).';
        temp_max6 = max((abs(sum(a6.*repmat(temp_phase6,1,K)))).^2);
   
        if temp_max6<min_value6
            min_value6= temp_max6;
            Best_n6 = n6;
        end
    end
    aa6 = sum(a6.*repmat(Phase_Set(Choose(Best_n6,:)).',1,K));
    Signal_Power6 = abs(aa6.^2);
    Peak_Power6  = max(Signal_Power6,[],2);
    Mean_Power6 = mean(Signal_Power6,2);
    PAPR_PTS6(nSymbol) = 10*log10(Peak_Power6./Mean_Power6);
end

% --------------------------------------------------------------------------
d0=zeros(1,12*2+1);
d4=zeros(1,16*2+1);
d5=zeros(1,12*2+1);
d6=zeros(1,12*2+1);
m=1;
    for papr0=0:0.5:12
        for nSymbol=1:MAX_SYMBOLS
        if  PAPR_Orignal(nSymbol)>papr0
            d0(m)=d0(m)+1;
        end
        
        if PAPR_PTS5(nSymbol)>papr0
            d5(m)=d5(m)+1;
        end
        if PAPR_PTS6(nSymbol)>papr0
            d6(m)=d6(m)+1;
        end
    end
        m=m+1;
    end     
    m=1;
    for papr1=0:0.5:16;
        for  nSymbol=1:MAX_SYMBOLS
        if PAPR_PTS4(nSymbol)>papr1
            d4(m)=d4(m)+1;
        end
    end
    m=m+1;
end
    d0=d0/MAX_SYMBOLS;
    d4=d4/MAX_SYMBOLS;
    d5=d5/MAX_SYMBOLS;
    d6=d6/MAX_SYMBOLS;
    papr0=0:0.5:12;
    papr1=0:0.5:16;
    semilogy(papr0,d0,'-k^',papr1,d4,'-.k',papr0,d5,'-kp',papr0,d6,'-ks')
% --------------------------------------------------------------------------
    

legend('Orignal','随机分割','相邻分割','交织分割')
title('V=4 随机、相邻、交织分组PAPR比较')
xlabel('PAPR0 [dB]');
ylabel('CCDF (Pr[PAPR>PAPR0])');
axis([2 12 0.001 1]);
% grid on

% --------------------------------------------------------------------------





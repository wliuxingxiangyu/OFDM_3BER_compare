clear all; clc;

K = 128;                                                                    % SIZE OF FFT 
V = 4;                                                                       % NUMBER OF SELECTIONS
QPSK_Set  = [1 -1 j -j];
Phase_Set = [1 -1];

Choose = [1 1 1 1; 1 1 1 2; 1 1 2 1; 1 2 1 1; 2 1 1 1;...
          1 1 2 2; 1 2 1 2; 1 2 2 1; 2 2 1 1; 2 1 2 1; 2 1 1 2;...
          2 2 2 1; 2 2 1 2; 2 1 2 2; 1 2 2 2; 2 2 2 2];
Choose_Len = 16;      

MAX_SYMBOLS  = 1e4;
PAPR_Orignal = zeros(1,MAX_SYMBOLS);
PAPR_PTS     = zeros(1,MAX_SYMBOLS);

for nSymbol=1:MAX_SYMBOLS
    Index = randint(1,K,length(QPSK_Set))+1;
    X = QPSK_Set(Index(1,:));                                               % Orignal Frequency domain signal
    x = ifft(X,[],2);                                                       % Time domain signal
    Signal_Power = abs(x.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_Orignal(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
    % PTS 
  Index= randperm(K); 
A = zeros(V,K); 
for v=1:V 
    A(v,Index(v:V:K)) = X(Index(v:V:K)); 
    end
    a = ifft(A,[],2);
    
    min_value = 10;
    for n=1:Choose_Len
        temp_phase = Phase_Set(Choose(n,:)).';
        temp_max = max(abs(sum(a.*repmat(temp_phase,1,K))));
        if temp_max<min_value
            min_value = temp_max;
            Best_n = n;
        end
    end
    aa = sum(a.*repmat(Phase_Set(Choose(Best_n,:)).',1,K));
        
    Signal_Power = abs(aa.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_PTS(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
end

[cdf1, PAPR1] = ecdf(PAPR_Orignal)
[cdf2, PAPR2] = ecdf(PAPR_PTS)
1-cdf2
%--------------------------------------------------------------------------
semilogy(PAPR2,1-cdf2,'-.k')
hold on;
cccc=1-cdf2;
% data = [PAPR2, cccc];
% save papr_64.am data -ascii;
%semilogy(PAPR2([1:2000:10000]),1-cdf2([1:2000:10000]),'-y')
title('子载波数不同的PAPR')
xlabel('PAPR0 [dB]');
ylabel('CCDF');


K = 256;                                                                    % SIZE OF FFT 
V = 4;                                                                       % NUMBER OF SELECTIONS
QPSK_Set  = [1 -1 j -j];
Phase_Set = [1 -1];

Choose = [1 1 1 1; 1 1 1 2; 1 1 2 1; 1 2 1 1; 2 1 1 1;...
          1 1 2 2; 1 2 1 2; 1 2 2 1; 2 2 1 1; 2 1 2 1; 2 1 1 2;...
          2 2 2 1; 2 2 1 2; 2 1 2 2; 1 2 2 2; 2 2 2 2];
Choose_Len = 16;      

MAX_SYMBOLS  = 1e4;
PAPR_Orignal = zeros(1,MAX_SYMBOLS);
PAPR_PTS     = zeros(1,MAX_SYMBOLS);

for nSymbol=1:MAX_SYMBOLS
    Index = randint(1,K,length(QPSK_Set))+1;
    X = QPSK_Set(Index(1,:));                                               % Orignal Frequency domain signal
    x = ifft(X,[],2);                                                       % Time domain signal
    Signal_Power = abs(x.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_Orignal(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
    % PTS 
  Index= randperm(K); 
A = zeros(V,K); 
for v=1:V 
    A(v,Index(v:V:K)) = X(Index(v:V:K)); 
    end
    a = ifft(A,[],2);
    
    min_value = 10;
    for n=1:Choose_Len
        temp_phase = Phase_Set(Choose(n,:)).';
        temp_max = max(abs(sum(a.*repmat(temp_phase,1,K))));
        if temp_max<min_value
            min_value = temp_max;
            Best_n = n;
        end
    end
    aa = sum(a.*repmat(Phase_Set(Choose(Best_n,:)).',1,K));
        
    Signal_Power = abs(aa.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_PTS(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
end

[cdf1, PAPR1] = ecdf(PAPR_Orignal)
[cdf2, PAPR2] = ecdf(PAPR_PTS)
1-cdf2
%--------------------------------------------------------------------------
semilogy(PAPR2,1-cdf2,'--k')
hold on;
cccc=1-cdf2;
% data = [PAPR2, cccc];
% save papr_128.am data -ascii;
%semilogy(PAPR2([1:2000:10000]),1-cdf2([1:2000:10000]),'-y')
title('子载波数不同的PAPR')
xlabel('PAPR0 [dB]');
ylabel('CCDF');

K = 512;                                                                    % SIZE OF FFT 
V = 4;                                                                       % NUMBER OF SELECTIONS
QPSK_Set  = [1 -1 j -j];
Phase_Set = [1 -1];

Choose = [1 1 1 1; 1 1 1 2; 1 1 2 1; 1 2 1 1; 2 1 1 1;...
          1 1 2 2; 1 2 1 2; 1 2 2 1; 2 2 1 1; 2 1 2 1; 2 1 1 2;...
          2 2 2 1; 2 2 1 2; 2 1 2 2; 1 2 2 2; 2 2 2 2];
Choose_Len = 16;      

MAX_SYMBOLS  = 1e4;
PAPR_Orignal = zeros(1,MAX_SYMBOLS);
PAPR_PTS     = zeros(1,MAX_SYMBOLS);

for nSymbol=1:MAX_SYMBOLS
    Index = randint(1,K,length(QPSK_Set))+1;
    X = QPSK_Set(Index(1,:));                                               % Orignal Frequency domain signal
    x = ifft(X,[],2);                                                       % Time domain signal
    Signal_Power = abs(x.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_Orignal(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
    % PTS 
  Index= randperm(K); 
A = zeros(V,K); 
for v=1:V 
    A(v,Index(v:V:K)) = X(Index(v:V:K)); 
    end
    a = ifft(A,[],2);
    
    min_value = 10;
    for n=1:Choose_Len
        temp_phase = Phase_Set(Choose(n,:)).';
        temp_max = max(abs(sum(a.*repmat(temp_phase,1,K))));
        if temp_max<min_value
            min_value = temp_max;
            Best_n = n;
        end
    end
    aa = sum(a.*repmat(Phase_Set(Choose(Best_n,:)).',1,K));
        
    Signal_Power = abs(aa.^2);
    Peak_Power   = max(Signal_Power,[],2);
    Mean_Power   = mean(Signal_Power,2);
    PAPR_PTS(nSymbol) = 10*log10(Peak_Power./Mean_Power);
    
end

[cdf1, PAPR1] = ecdf(PAPR_Orignal)
[cdf2, PAPR2] = ecdf(PAPR_PTS)
1-cdf2
%--------------------------------------------------------------------------
semilogy(PAPR2,1-cdf2,'-k')
cccc=1-cdf2;
% data = [PAPR2, cccc];
% save papr_64.am data -ascii;
%semilogy(PAPR2([1:2000:10000]),1-cdf2([1:2000:10000]),'-y')
title('子载波数不同的PAPR')
xlabel('PAPR0 [dB]');
ylabel('CCDF');

legend('N=128','N=256','N=512',3)



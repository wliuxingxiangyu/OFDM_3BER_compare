% Chow's Algorithm
%----------------------
%Programmed by xia
%2009年5月21日, 11:52
%----------------------
% function [bits_alloc, power_alloc] = chow_algo(SNR,N_subc,gap,target_bits)
function [bits_alloc, power_alloc,Iterate_count] = chow_algo(SNR,N_subc,gap,target_bits)
%--------------------input variables -------------------------
% SNR          每个子信道的信噪比（1×N_subc)向量 (dB)
% N_subc       子载波数
% gap          信噪比间隙（常量）(dB)
% target_bits  总比特数（数据传输速率）
%--------------------output variables------------------------
% bits_alloc
% power_alloc
% Iterate_count
% ---------------------initialization-------------------------
margin=0;                     %门限值
Max_count=10;               %最大迭代次数
Iterate_count=0;              %迭代计数器
N_use=N_subc;                 %可用子载波数
total_bits=0;                 %分配的总比特数
power_alloc=zeros(1,N_subc);  %功率分配结果（1×N_subc)向量
bits_alloc=zeros(1,N_subc);   %比特分配结果（1×N_subc)向量
temp_bits=zeros(1,N_subc);    %每个子载波分配的比特数理论值,非整数
round_bits=zeros(1,N_subc);   %每个子载波分配的比特数取整值
diff=zeros(1,N_subc);         %每个子载波比特分配的误差（余量）
%-----------------------------bits allocation-------------------------
while (total_bits~=target_bits)&&(Iterate_count<Max_count)
    %--------------------------------------------------------------
    Iterate_count=Iterate_count+1;
    N_use=N_subc;
    temp_bits=log2(1+SNR./(1+margin/gap)); %关键一点，理解SNR是包含gap的，所以对原表达式变形如左！~ 
    round_bits=round(temp_bits);
    diff=temp_bits-round_bits;
    %--------------------------------------------------------------
    total_bits=sum(round_bits);
    if(total_bits==0)
        disp('the channel is not be used');
        total_bits
    end
    nuc=length(find(round_bits==0)); %
    N_use=N_subc-nuc; %
%     %========================Algorithm Alteration========================
%     diff_total=total_bits-target_bits;
%     if(2^(diff_total/N_use)>0)
    margin=margin+10*log10(2^((total_bits-target_bits)/N_use));
%     else
%         break;
%     end
%     %========??????===========Algorithm Alteration====?????================
%     if(abs(diff_total)<=10)
%         break;
%     end
%     %==================================END=================================
end
%------------------------------bits alteration--------------------------
while(total_bits>target_bits)
    use_ind=find(round_bits>0);
    diff_use=diff(use_ind);  
    id=find(diff_use==min(diff_use),1); %好好理解索引（序号）的对应关系
    ind_alter=use_ind(id);  %好好理解索引（序号）的对应关系
    round_bits(ind_alter)=round_bits(ind_alter)-1;
    diff(ind_alter)=diff(ind_alter)+1;
    total_bits=sum(round_bits);
end
while(total_bits<target_bits)
    use_ind=find(round_bits~=0);
    diff_use=diff(use_ind);
    id=find(diff_use==max(diff_use),1);
    ind_alter=use_ind(id);
    round_bits(ind_alter)=round_bits(ind_alter)+1;
    diff(ind_alter)=diff(ind_alter)-1;
    total_bits=sum(round_bits);
end
bits_alloc=round_bits;
%--------------------------power allocation-----------------------------
power_alloc=(2.^bits_alloc-1)./SNR;
end
%---------------------------end of file------------------------------


    




    
    
    
    
    
    
    
    
    
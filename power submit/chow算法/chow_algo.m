% Chow's Algorithm
%----------------------
%Programmed by xia
%2009��5��21��, 11:52
%----------------------
% function [bits_alloc, power_alloc] = chow_algo(SNR,N_subc,gap,target_bits)
function [bits_alloc, power_alloc,Iterate_count] = chow_algo(SNR,N_subc,gap,target_bits)
%--------------------input variables -------------------------
% SNR          ÿ�����ŵ�������ȣ�1��N_subc)���� (dB)
% N_subc       ���ز���
% gap          ����ȼ�϶��������(dB)
% target_bits  �ܱ����������ݴ������ʣ�
%--------------------output variables------------------------
% bits_alloc
% power_alloc
% Iterate_count
% ---------------------initialization-------------------------
margin=0;                     %����ֵ
Max_count=10;               %����������
Iterate_count=0;              %����������
N_use=N_subc;                 %�������ز���
total_bits=0;                 %������ܱ�����
power_alloc=zeros(1,N_subc);  %���ʷ�������1��N_subc)����
bits_alloc=zeros(1,N_subc);   %���ط�������1��N_subc)����
temp_bits=zeros(1,N_subc);    %ÿ�����ز�����ı���������ֵ,������
round_bits=zeros(1,N_subc);   %ÿ�����ز�����ı�����ȡ��ֵ
diff=zeros(1,N_subc);         %ÿ�����ز����ط������������
%-----------------------------bits allocation-------------------------
while (total_bits~=target_bits)&&(Iterate_count<Max_count)
    %--------------------------------------------------------------
    Iterate_count=Iterate_count+1;
    N_use=N_subc;
    temp_bits=log2(1+SNR./(1+margin/gap)); %�ؼ�һ�㣬���SNR�ǰ���gap�ģ����Զ�ԭ���ʽ��������~ 
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
    id=find(diff_use==min(diff_use),1); %�ú������������ţ��Ķ�Ӧ��ϵ
    ind_alter=use_ind(id);  %�ú������������ţ��Ķ�Ӧ��ϵ
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


    




    
    
    
    
    
    
    
    
    
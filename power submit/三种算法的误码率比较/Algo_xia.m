%---------------------改进的算法 Rb最大化----------------
function [bit_alloc power_alloc]=Algo_xia(Num_subc,Pt,K,gain_subc,gap,noise_var,Rt)
snr_subc=SNR_subc(gap,gain_subc,noise_var);
step=1;
%-----------------Power allocation init------------------------
init_power_alloc=(Pt+sum(1./snr_subc))/Num_subc-1./snr_subc;
while(length(find(init_power_alloc<0))~=0)
    neg_index=find(init_power_alloc<=0);
    pos_index=find(init_power_alloc>0);
    init_power_alloc(neg_index)=0;
    num_use=length(pos_index);
    snr_use=snr_subc(pos_index);
    power_temp=(Pt+sum(1./snr_use))/num_use-1./snr_use;
    init_power_alloc(pos_index)=power_temp;
end
%-------------Bit allocation init and round-----------------------------
bit_theory=log2(1+init_power_alloc.*snr_subc);
bit_round=round(bit_theory);
%-------------Power round----------------------------
function power_round=Power(bit,snr_subc)
power_round=(2.^bit-1)./snr_subc;
end
power_round=Power(bit_round,snr_subc);
%-------------Power diff------------------
power_diff=init_power_alloc-power_round;
power_total=sum(power_round);
%-------------Power and Bit alteration---------------------
while(power_total<Pt)
    index_use=find(bit_round>=0);
    id_max=find(power_diff(index_use)==max(power_diff(index_use)),1);
    index_max=index_use(id_max);
    power_add=Power(bit_round(index_max)+step,snr_subc(index_max))-...
        Power(bit_round(index_max),snr_subc(index_max));
    if(power_total+power_add<=Pt)
        bit_round(index_max)=bit_round(index_max)+step;
        power_round(index_max)=power_round(index_max)+power_add;
        power_diff(index_max)=power_diff(index_max)-power_add;
        power_total=sum(power_round); %power_total=power_total+power_add
    else
        break;
    end
end
while(power_total>Pt)
    %---------修正调整过程中出现负比特的错误--------------
    index_use=find(bit_round>=step);
    %-----------------------------------------------
    id_min=find(power_diff(index_use)==min(power_diff(index_use)),1);
    index_min=index_use(id_min);
    power_reduce=Power(bit_round(index_min),snr_subc(index_min))-...
        Power(bit_round(index_min)-step,snr_subc(index_min));
    if(power_total-power_reduce>=Pt)
        bit_round(index_min)=bit_round(index_min)-step;
        power_round(index_min)=power_round(index_min)-power_reduce;
        power_diff(index_min)=power_diff(index_min)+power_reduce;
        power_total=sum(power_round);%power_total=power_total-power_reduce
    else
        break;
    end
end
%================================Algo 改动=================================
% index_alter=find(bit_round>K);
% bit_round(index_alter)=K;
% for i=1:Num_subc
%      if(bit_round(i)>K)
%         bit_round(i)=K;
%     end
% end
%----------------------------改动-------------------------------
bit_coef=bit_round./sum(bit_round);
bit_temp=bit_coef.*Rt;
bit_round_2=round(bit_temp);
bit_diff=bit_temp-bit_round_2;
bit_total=sum(bit_round_2);
%---------------
for i=1:Num_subc
     if(bit_round_2(i)>K)
        bit_round_2(i)=K;
    end
end
while(bit_total>Rt)
    index_use=find(bit_round_2>0);
    diff_use=bit_diff(index_use);  
    id=find(diff_use==min(diff_use),1); %好好理解索引（序号）的对应关系
    ind_alter=index_use(id);  %好好理解索引（序号）的对应关系
    bit_round_2(ind_alter)=bit_round_2(ind_alter)-1;
    bit_diff(ind_alter)=bit_diff(ind_alter)+1;
    bit_total=sum(bit_round_2);
end
while(bit_total<Rt)
    index_use=find(bit_round_2>=0);
    diff_use=bit_diff(index_use);
    id=find(diff_use==max(diff_use),1);
    ind_alter=index_use(id);
    if(bit_round_2(ind_alter)<K)
    bit_round_2(ind_alter)=bit_round_2(ind_alter)+1;
    else
        bit_diff(ind_alter)=-inf;
    end
    bit_diff(ind_alter)=bit_diff(ind_alter)-1;
    bit_total=sum(bit_round_2);
end
bit_alloc=bit_round_2;
power_alloc=power_round;
end






    
    
    
        
        
        
        
        
    
    
    
 










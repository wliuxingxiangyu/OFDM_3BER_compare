%--------------EBA and EPA----------------
function [bit_alloc power_alloc bit_theory]=MaxC_EPA(Pt,Num_subc,gain_subc,noise_var,gap,Rt,K)
snr_subc=SNR_subc(gap,gain_subc,noise_var);
%---------------------init---------------------
power_alloc=zeros(1,Num_subc);
bit_alloc=zeros(1,Num_subc);
bit_temp=zeros(1,Num_subc);
bit_round=zeros(1,Num_subc);
bit_diff=zeros(1,Num_subc);
%--------------EPA-----------------------
power_alloc(:)=Pt/Num_subc;
%-----------------Max Capacity BA------------
bit_theory=log2(1+power_alloc.*snr_subc);
% bit_alloc=round(bit_theory);
bit_coef=bit_theory./sum(bit_theory);
bit_temp=bit_coef.*Rt;
bit_round=round(bit_temp);
bit_diff=bit_temp-bit_round;
bit_total=sum(bit_round);
%---------------------------bit alteration---------------------
for i=1:Num_subc
     if(bit_round(i)>K)
        bit_round(i)=K;
    end
end
while(bit_total>Rt)
    index_use=find(bit_round>0);
    diff_use=bit_diff(index_use);  
    id=find(diff_use==min(diff_use),1); %好好理解索引（序号）的对应关系
    ind_alter=index_use(id);  %好好理解索引（序号）的对应关系
    bit_round(ind_alter)=bit_round(ind_alter)-1;
    bit_diff(ind_alter)=bit_diff(ind_alter)+1;
    bit_total=sum(bit_round);
end
while(bit_total<Rt)
    index_use=find(bit_round>=0);
    diff_use=bit_diff(index_use);
    id=find(diff_use==max(diff_use),1);
    ind_alter=index_use(id);
    if(bit_round(ind_alter)<K)
    bit_round(ind_alter)=bit_round(ind_alter)+1;
    else
        bit_diff(ind_alter)=-inf;
    end
    bit_diff(ind_alter)=bit_diff(ind_alter)-1;
    bit_total=sum(bit_round);
end
bit_alloc=bit_round;
end




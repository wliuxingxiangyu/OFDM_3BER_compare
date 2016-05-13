%---------Water filling algo--------------
function [bit_alloc power_alloc bit_theory]=waterfill(Num_subc,Pt,gain_subc,noise_var,gap,B,K,Rt)
snr_subc=SNR_subc(gap,gain_subc,noise_var);
%------------remove the subcarrier with zero gain-------------------
% [gain_subc,index]=sort(gain_subc,'descend');
% num_zero_gain=length(find(gain_subc==0));
% num_use=Num_subc-num_zero_gain;
%------------------water filling allocation--------------
power_alloc=(Pt+sum(1./snr_subc))/Num_subc-1./snr_subc;
while(length(find(power_alloc<0))~=0)
    neg_index=find(power_alloc<=0);
    pos_index=find(power_alloc>0);
    power_alloc(neg_index)=0;
    num_use=length(pos_index);
    snr_use=snr_subc(pos_index);
    power_temp=(Pt+sum(1./snr_use))/num_use-1./snr_use;
    power_alloc(pos_index)=power_temp;
end
bit_theory=log2(1+power_alloc.*snr_subc);
% bit_alloc=round(bit_theory);
%-----------------Max Capacity BA------------
bit_alloc=zeros(1,Num_subc);
bit_temp=zeros(1,Num_subc);
bit_round=zeros(1,Num_subc);
bit_diff=zeros(1,Num_subc);
%-----------------------------------------
bit_coef=bit_theory./sum(bit_theory);
bit_temp=bit_coef.*Rt;
bit_round=round(bit_temp);
bit_diff=bit_temp-bit_round;
bit_total=sum(bit_round);
%--------------------bit alteration-----------
for i=1:Num_subc
     if(bit_round(i)>K)
        bit_round(i)=K;
%     else(mod(bit_alloc(i),2)~=0&bit_alloc(i)~=1)
%         bit_alloc(i)=bit_alloc(i)-1;
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
%-----------------------equal bit allocation------------
% for i=1:Num_subc
% bit_alloc(i)=Rt/Num_subc;
% end
end



    
        





    






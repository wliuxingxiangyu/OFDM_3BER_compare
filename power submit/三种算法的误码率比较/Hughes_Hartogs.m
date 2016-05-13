%Hughes-Hartogs Algorithm
%-------------------------
%Programmed by Xia zhaokang 
%May-22-2009
%-------------------------
% function [bit_alloc, power_alloc]=Hughes-Hartogs(N_subc,Rb,M,BER,Noise,H)
function [bit_alloc,power_alloc]=Hughes_Hartogs(N_subc,Rb,M,BER,Noise,H)
% ---------------------initialization-------------------
bit_alloc=zeros(1,N_subc);
power_alloc=zeros(1,N_subc);
bit_total=0;
step=2;
%************************** DO **************************
%-----------------------increment of power---------------
%====改动:去掉for循环，改为矩阵计算========================
%  power_add=(f_mpsk(bit_alloc+1,BER,Noise)-...
%      f_mpsk(bit_alloc,BER,Noise))./H.^2;
 power_add=(f_mqam(bit_alloc+step,BER,Noise)-...
     f_mqam(bit_alloc,BER,Noise))./H.^2;
%============================================================
%----------------------find min index--------------------
min_add=min(power_add);
index_min=find(power_add==min_add,1);
%---------------------first bit allocation--------------------
bit_alloc(index_min)=bit_alloc(index_min)+step;
bit_total=sum(bit_alloc);
%************************** WHILE ************************
while(bit_total<Rb)
    if(bit_alloc(index_min)~=M)
%-----------------------increment of power---------------
%         for i=1:N_subc
%              power_add(i)=(f_mpsk(bit_alloc(i)+1,BER,Noise)-...
%                  f_mpsk(bit_alloc(i),BER,Noise))/H(i)^2;
% %              power_add(i)=(f_mqam(bit_alloc(i)+1,BER,Noise)-...
% %                  f_mqam(bit_alloc(i),BER,Noise))/H(i)^2;
%         end
%====改动:去掉for循环，改为矩阵计算========================
%  power_add=(f_mpsk(bit_alloc+step,BER,Noise)-...
%      f_mpsk(bit_alloc,BER,Noise))./H.^2;
 power_add=(f_mqam(bit_alloc+step,BER,Noise)-...
     f_mqam(bit_alloc,BER,Noise))./H.^2;
%============================================================
%---------------------bit allocation loop --------------------        
        min_add=min(power_add);
        index_min=find(power_add==min_add,1);
        bit_alloc(index_min)=bit_alloc(index_min)+step;
        bit_total=sum(bit_alloc);
    else
        power_add(index_min)=inf;
%---------------------bit allocation loop--------------------         
        min_add=min(power_add);
        index_min=find(power_add==min_add,1);
        bit_alloc(index_min)=bit_alloc(index_min)+step;
        bit_total=sum(bit_alloc);
    end
end
%---------------------power allocation--------------------------
% for i=1:N_subc
%      power_alloc(i)=f_mpsk(bit_alloc(i),BER,Noise)/H(i)^2;
% %     power_alloc(i)=f_mqam(bit_alloc(i),BER,Noise)/H(i)^2;
% end
% power_alloc=f_mpsk(bit_alloc,BER,Noise)./H.^2;
 power_alloc=f_mqam(bit_alloc,BER,Noise)./H.^2;
end
%-----------------------End of File------------------------------
        
    




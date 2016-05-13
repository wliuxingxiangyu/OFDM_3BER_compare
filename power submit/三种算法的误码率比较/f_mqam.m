function power=f_mqam(c,Pe,N_psd)
% if(mod(c,2)~=0)
%     error('The number of bit must be Even in MQAM ')
% end
power=zeros(1,length(c));
% if c==0
%     power=0;
% else
index_zero=find(c==0);
power(index_zero)=0;
index_use=find(c);
M=2.^c(index_use);
power(index_use)=N_psd./3.*(M-1).*(Qinv(Pe.*sqrt(M)./(4.*(sqrt(M)-1)))).^2;
end

    

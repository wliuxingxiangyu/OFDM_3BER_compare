function power=f_mqam(c,Pe,N_psd)
if(mod(c,2)~=0)
    error('The number of bit must be Even in MQAM ')
end
if c==0
    power=0;
else
M=2^c;
power=N_psd/3*(M-1)*(Qinv(Pe*sqrt(M)/(4*(sqrt(M)-1))))^2;
end
end

    

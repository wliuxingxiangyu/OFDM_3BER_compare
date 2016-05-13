%--------------EBA and EPA----------------
function [bit_alloc power_alloc bit_theory]=EBA_EPA(Pt,B,Num_subc,gain_subc,noise_var,gap,Rt)
snr_subc=SNR_subc(gap,gain_subc,noise_var);
%---------------------init---------------------
power_alloc=zeros(1,Num_subc);
bit_alloc=zeros(1,Num_subc);
%--------------bit and power equal allocation-----------------------
power_alloc(:)=Pt/Num_subc;
bit_alloc(:)=Rt/Num_subc;
end




%---------compute snr of subcarriers---------------
function snr_subc=SNR_subc(gap,gain_subc,noise_var)
%--------------------------------
%gap in dB
%snr_subc in db
%------------------------------
snr_subc=gain_subc.^2/(noise_var*gap);
end

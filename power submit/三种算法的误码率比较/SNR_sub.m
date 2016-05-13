function snr_sub=SNR_sub(gain_subc,Noise_var,gap)
snr_sub=gain_subc.^2./(Noise_var.*gap);
end

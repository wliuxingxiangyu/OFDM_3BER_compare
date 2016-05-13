%---------------------AWGN Addition---------------
function out_AWGN=Gngauss(Noise_var,out_channel)
Length=length(out_channel);
Noise_complex=sqrt(Noise_var).*(randn(1,Length)+j.*randn(1,Length));
out_AWGN=out_channel+Noise_complex;
end

%------------------GI Insert--------------
function out_GIinsert=GI_insert(out_IFFT,GI_length)
num_subc=length(out_IFFT);%num_subc=64
out_GIinsert=[  out_IFFT(  (num_subc-GI_length+1):num_subc  );   out_IFFT   ];%out_IFFT的后面的八分之一移到前面,[57行到64行;1行-64行]
out_GIinsert=conj(out_GIinsert');%求复数的共轭（conjugate）
end



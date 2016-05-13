%------------------GI Insert--------------
function out_GIinsert=GI_insert(out_IFFT,GI_length)
num_subc=length(out_IFFT);
out_GIinsert=[out_IFFT((num_subc-GI_length+1):num_subc);out_IFFT];
out_GIinsert=conj(out_GIinsert');
end



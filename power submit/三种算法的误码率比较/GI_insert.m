%------------------GI Insert--------------
function out_GIinsert=GI_insert(out_IFFT,GI_length)
num_subc=length(out_IFFT);%num_subc=64
out_GIinsert=[  out_IFFT(  (num_subc-GI_length+1):num_subc  );   out_IFFT   ];%out_IFFT�ĺ���İ˷�֮һ�Ƶ�ǰ��,[57�е�64��;1��-64��]
out_GIinsert=conj(out_GIinsert');%�����Ĺ��conjugate��
end



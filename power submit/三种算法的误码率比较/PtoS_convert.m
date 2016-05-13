%---------------Adaptive Parallel to Serial Conversion----------
%----------function------------
function Rx_sequence=PtoS_convert(out_demodulated,bitnum_sub,Rb)
num_sub=length(bitnum_sub);
Rx_sequence=zeros(1,Rb);
index=zeros(1,num_sub);
for i=1:num_sub
    index(i+1)=index(i)+bitnum_sub(i);
end
for i=1:num_sub
   Rx_sequence((index(i)+1):index(i+1))=out_demodulated(i,1:bitnum_sub(i));
end
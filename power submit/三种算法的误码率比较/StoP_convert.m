%---------------Adaptive Serial to Parallel Conversion---����IFFT-------
%Bit_sequence:���ͱ���,bitnum_sub:���㷨����ı�����1*64,M:max number of bit for per subcarrier
function bit_sub=StoP_convert(Bit_sequence,bitnum_sub,M)
num_sub=length(bitnum_sub);
bit_sub=zeros(num_sub,M);
index=zeros(1,num_sub);
for i=1:num_sub
    index(i+1)=index(i)+bitnum_sub(i);
end
for i=1:num_sub
    bit_sub(i,1:bitnum_sub(i))=Bit_sequence((index(i)+1):index(i+1));
end



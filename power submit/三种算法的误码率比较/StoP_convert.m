%---------------Adaptive Serial to Parallel 串并变换--输出值bit_sub用于IFFT-------
%srcBit_sequence:发送比特,bitNumPerSubcarrier:由算法分配的比特数1*64,M:每个子载波分配的最大比特数
function outbit_sub=StoP_convert(srcBit_sequence,bitNumPerSubcarrier,M)
numSubcarrier=length(bitNumPerSubcarrier);
outbit_sub=zeros(numSubcarrier,M);%  M列 用于限制outbit_sub的最大列标。
index=zeros(1,numSubcarrier);
for i=1:numSubcarrier
    index(i+1)=index(i)+bitNumPerSubcarrier(i);
end
for i=1:numSubcarrier
    outbit_sub( i,1:bitNumPerSubcarrier(i)  )=srcBit_sequence( (index(i)+1):index(i+1) );
end %  outbit_sub为二维，第i行的:“1列到bitNumPerSubcarrier(i)列”存 信源序列，
%outbit_sub的第1列存 srcBit_sequence的第1到5个比特
%outbit_sub的第2列存 srcBit_sequence的第6到9个比特



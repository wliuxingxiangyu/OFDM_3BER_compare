%---------------Adaptive Serial to Parallel �����任--���ֵbit_sub����IFFT-------
%srcBit_sequence:���ͱ���,bitNumPerSubcarrier:���㷨����ı�����1*64,M:ÿ�����ز��������������
function outbit_sub=StoP_convert(srcBit_sequence,bitNumPerSubcarrier,M)
numSubcarrier=length(bitNumPerSubcarrier);
outbit_sub=zeros(numSubcarrier,M);%  M�� ��������outbit_sub������бꡣ
index=zeros(1,numSubcarrier);
for i=1:numSubcarrier
    index(i+1)=index(i)+bitNumPerSubcarrier(i);
end
for i=1:numSubcarrier
    outbit_sub( i,1:bitNumPerSubcarrier(i)  )=srcBit_sequence( (index(i)+1):index(i+1) );
end %  outbit_subΪ��ά����i�е�:��1�е�bitNumPerSubcarrier(i)�С��� ��Դ���У�
%outbit_sub�ĵ�1�д� srcBit_sequence�ĵ�1��5������
%outbit_sub�ĵ�2�д� srcBit_sequence�ĵ�6��9������



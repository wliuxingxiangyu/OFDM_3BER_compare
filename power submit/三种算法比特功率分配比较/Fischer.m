%----------------------Fischer Algo Perfect!-------------------
function [bit_alloc power_alloc]=Fischer(Num_subc,Rt,Pt,gain_subc)
%------------------bit allocation -----------
N_H=1./gain_subc.^2;
LD=log2(N_H);
index_use0=1:Num_subc;     %��������ز�����I��ʼ��Ϊ{1��Num_subc}
num_use=Num_subc;          %��������ز�����ʼ������Num_subc
bit_temp0=(Rt+sum(LD))./Num_subc-LD; %����I�е����ز���ʼ���ط���
bit_temp=zeros(1,Num_subc);  %���ص���ǰ����ʱ����
%------���ñ�־����flag��ʵ��do while���------
flag=1; 
while flag
    id_remove=find(bit_temp0(index_use0)<=0); %������Ҫ�Ƴ������ز�����ڼ���I�е�λ�ã�I��Ԫ���Զ���������
    index_remove=index_use0(id_remove); %�����Ƴ������ز���ţ����ؼ�һ������⣡��
    if(length(index_remove)==0)   %û����Ҫ�Ƴ�I�е����ز�������ѭ�����������round
        break;
    end    
    index_use0=setdiff(index_use0,index_remove); %���ظ��º�ļ���I
    num_use=length(index_use0);   %���º��I�п������ز���Ŀ
    bit_temp0(index_use0)=(Rt+sum(LD(index_use0)))./num_use-LD(index_use0); %���µļ���I�����¼�����ط���
    flag=1;
end
index_use=index_use0;   %������I��index_use0���еļ������ز���ŷ��ظ�����index_use
bit_temp(index_use)=bit_temp0(index_use);  %����������ز�������ı��������ظ�bit_temp,�������������ز��ı��ط��䶼��Ϊ0
%-----------------bit round---------------------------
bit_round=zeros(1,Num_subc);
bit_round(index_use)=round(bit_temp(index_use));
bit_diff(index_use)=bit_temp(index_use)-bit_round(index_use);
bit_total=sum(bit_round(index_use));
%------------------bit alteration--------------------
while(bit_total>Rt)
    id_alter=find(bit_round(index_use)>0); %�Ķ�
    index_alter=index_use(id_alter);     %id_alter :index_use(���ز���ţ������λ�ã�˳��
    min_diff=min(bit_diff(index_alter)); 
    id_min=find(bit_diff(index_alter)==min_diff,1);%�Ķ�
    index_min=index_alter(id_min);%�Ķ�
    bit_round(index_min)=bit_round(index_min)-1;
    bit_total=bit_total-1;
    bit_diff(index_min)=bit_diff(index_min)+1;
end
while(bit_total<Rt)
    id_alter=find(bit_round(index_use)>0);%�Ķ�
    index_alter=index_use(id_alter); %�Ķ�
    max_diff=max(bit_diff(index_alter));
    id_max=find(bit_diff(index_alter)==max_diff,1);%�Ķ�
    index_max=index_alter(id_max);%�Ķ�
    bit_round(index_max)=bit_round(index_max)+1;
    bit_total=bit_total+1;
    bit_diff(index_max)=bit_diff(index_max)-1;
end
%----------------bit allocation------------------
bit_alloc=bit_round;
%------------------power allocation-----------------------
power_alloc=zeros(1,Num_subc);   
%---------------�Ķ������ҵ����յļ������ز�����-----------------------
index_use2=find(bit_alloc>0);
power_alloc(index_use2)=Pt.*(N_H(index_use2)).*2.^bit_round(index_use2)./...
    (sum(N_H(index_use2)).*2.^bit_round(index_use2));   %Ϊ�������ز�������أ����������ز����书�ʶ���Ϊ0
%-----------------EOF----------------------





    
    
        
        
    





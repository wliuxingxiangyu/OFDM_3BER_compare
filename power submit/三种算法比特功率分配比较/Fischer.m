%----------------------Fischer Algo Perfect!-------------------
function [bit_alloc power_alloc]=Fischer(Num_subc,Rt,Pt,gain_subc)
%------------------bit allocation -----------
N_H=1./gain_subc.^2;
LD=log2(N_H);
index_use0=1:Num_subc;     %激活的子载波集合I初始化为{1：Num_subc}
num_use=Num_subc;          %激活的子载波数初始化等于Num_subc
bit_temp0=(Rt+sum(LD))./Num_subc-LD; %集合I中的子载波初始比特分配
bit_temp=zeros(1,Num_subc);  %比特调整前的临时变量
%------利用标志变量flag，实现do while语句------
flag=1; 
while flag
    id_remove=find(bit_temp0(index_use0)<=0); %返回需要移除的子载波序号在集合I中的位置，I中元素自动升序排列
    index_remove=index_use0(id_remove); %返回移除的子载波序号，！关键一步，理解！～
    if(length(index_remove)==0)   %没有需要移除I中的子载波，跳出循环，进入比特round
        break;
    end    
    index_use0=setdiff(index_use0,index_remove); %返回更新后的集合I
    num_use=length(index_use0);   %更新后的I中可用子载波数目
    bit_temp0(index_use0)=(Rt+sum(LD(index_use0)))./num_use-LD(index_use0); %在新的集合I中重新计算比特分配
    flag=1;
end
index_use=index_use0;   %将集合I（index_use0）中的激活子载波序号返回给变量index_use
bit_temp(index_use)=bit_temp0(index_use);  %将激活的子载波所分配的比特数返回给bit_temp,其他不可用子载波的比特分配都置为0
%-----------------bit round---------------------------
bit_round=zeros(1,Num_subc);
bit_round(index_use)=round(bit_temp(index_use));
bit_diff(index_use)=bit_temp(index_use)-bit_round(index_use);
bit_total=sum(bit_round(index_use));
%------------------bit alteration--------------------
while(bit_total>Rt)
    id_alter=find(bit_round(index_use)>0); %改动
    index_alter=index_use(id_alter);     %id_alter :index_use(子载波序号）的相对位置（顺序）
    min_diff=min(bit_diff(index_alter)); 
    id_min=find(bit_diff(index_alter)==min_diff,1);%改动
    index_min=index_alter(id_min);%改动
    bit_round(index_min)=bit_round(index_min)-1;
    bit_total=bit_total-1;
    bit_diff(index_min)=bit_diff(index_min)+1;
end
while(bit_total<Rt)
    id_alter=find(bit_round(index_use)>0);%改动
    index_alter=index_use(id_alter); %改动
    max_diff=max(bit_diff(index_alter));
    id_max=find(bit_diff(index_alter)==max_diff,1);%改动
    index_max=index_alter(id_max);%改动
    bit_round(index_max)=bit_round(index_max)+1;
    bit_total=bit_total+1;
    bit_diff(index_max)=bit_diff(index_max)-1;
end
%----------------bit allocation------------------
bit_alloc=bit_round;
%------------------power allocation-----------------------
power_alloc=zeros(1,Num_subc);   
%---------------改动：先找到最终的激活子载波集合-----------------------
index_use2=find(bit_alloc>0);
power_alloc(index_use2)=Pt.*(N_H(index_use2)).*2.^bit_round(index_use2)./...
    (sum(N_H(index_use2)).*2.^bit_round(index_use2));   %为激活子载波分配比特，不可用子载波发射功率都置为0
%-----------------EOF----------------------





    
    
        
        
    





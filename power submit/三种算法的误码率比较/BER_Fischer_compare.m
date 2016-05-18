function [ ]=BER_Fischer_compare()
%---����BER_Fischer����------------
load BER_Fischer.am -ascii;
BER_F_x = BER_Fischer(1,:);
BER_F_y = BER_Fischer(2,:)./1000;

for i=1:length(BER_F_y)
    if BER_F_y(i)==0
        BER_F_y(i)=(0.95-1000*eps)*BER_F_y(i-1);%��ֵeps
    end    
end
%---����BER_ImFischer����------------
load BER_ImFischer.am -ascii;
BER_ImF_x = BER_ImFischer(1,:);
BER_ImF_y = BER_ImFischer(2,:)./1000;

for i=1:length(BER_ImF_y)
    if BER_ImF_y(i)==0
        BER_ImF_y(i)=(0.95-2000*eps)*BER_ImF_y(i-1);%��ֵeps
    end    
end

semilogy(BER_F_x, BER_F_y,'ks-');%Fischer�㷨
hold on;
semilogy(BER_ImF_x, BER_ImF_y,'k*-');%�Ľ���ImFischer�㷨
hold off;

legend('Fischer�㷨','ImFischer�㷨', 3)
xlabel('�����(dB)', 'FontSize',12);

set(gca,'XTick',0:2: length(BER_F_x)  );%���ò���Ϊ1.S/N=0dB ��S=N��ʱ���������
ylabel('BER ', 'FontSize',12);
grid on;
end
function [ ]=ser_Fischer_compare()
load ser_Fischer.am -ascii;
ser_F_x = ser_Fischer(1,:);
ser_F_y = ser_Fischer(2,:)./1000;

for i=2:length(ser_F_y)
    if ser_F_y(i)==0
        ser_F_y(i)=0.95*ser_F_y(i-1);
    end    
end
% [yMax,iMax]=max(ser_F_y); %������x�е����ֵyMax�����Ԫ�ص�λ��iMax
% [yMin,iMin]=min(ser_F_y); %������x�е����ֵ�����Ԫ�ص�λ��

semilogy(ser_F_x, ser_F_y,'ks-');
% plot(ser_F_x, ser_F_y,'ks-');
hold off;

legend('Fischer�㷨', 3)
xlabel('�����(dB)', 'FontSize',12);


% axis([1 length(ser_F_x)   0.1*yMin  1.3*yMax]);%ʹ�������1��ʼ
set(gca,'XTick',0:2: length(ser_F_x)  );%���ò���Ϊ1.
% set(gca,'YTick',10e-6:1: 10e-0  );%���ò���Ϊ1.
ylabel('BER ', 'FontSize',12);
grid on;
end
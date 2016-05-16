function [ ]=ser_Fischer_compare()
load ser_Fischer.am -ascii;
ser_F_x = ser_Fischer(1,:);
ser_F_y = ser_Fischer(2,:)./1000;

for i=2:length(ser_F_y)
    if ser_F_y(i)==0
        ser_F_y(i)=0.95*ser_F_y(i-1);
    end    
end
% [yMax,iMax]=max(ser_F_y); %求向量x中的最大值yMax及其该元素的位置iMax
% [yMin,iMin]=min(ser_F_y); %求向量x中的最大值及其该元素的位置

semilogy(ser_F_x, ser_F_y,'ks-');
% plot(ser_F_x, ser_F_y,'ks-');
hold off;

legend('Fischer算法', 3)
xlabel('信噪比(dB)', 'FontSize',12);


% axis([1 length(ser_F_x)   0.1*yMin  1.3*yMax]);%使横坐标从1开始
set(gca,'XTick',0:2: length(ser_F_x)  );%设置步长为1.
% set(gca,'YTick',10e-6:1: 10e-0  );%设置步长为1.
ylabel('BER ', 'FontSize',12);
grid on;
end
function [ ]=ser_Fischer_compare()
load ser_Fischer.am -ascii;
ser_F_x = ser_Fischer(1,:);
ser_F_y = ser_Fischer(2,:);

% for i=2:length(ser_F_y)
%     if ser_F_y(i)==0
%         ser_F_y(i)=0.95*ser_F_y(i-1);
%     end    
% end
ser_F_y
semilogy(ser_F_x, ser_F_y,'ks-');
hold on;
% plot(ser_F_x, ser_F_y,'ko-'); %改进算法画图
hold off;

legend('Fischer算法', 3)
xlabel('信噪比(dB)', 'FontSize',12);
% set(gca,'XTick',0:1:(length(ser_F_x)+1)  );
set(gca,'XTick',0:1: length(ser_F_x)  );
ylabel('BER ', 'FontSize',12);
grid on;
end
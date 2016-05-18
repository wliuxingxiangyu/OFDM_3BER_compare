function [ ]=BER_Fischer_compare()
%---绘制BER_Fischer曲线------------
load BER_Fischer.am -ascii;
BER_F_x = BER_Fischer(1,:);
BER_F_y = BER_Fischer(2,:)./1000;

for i=1:length(BER_F_y)
    if BER_F_y(i)==0
        BER_F_y(i)=(0.95-1000*eps)*BER_F_y(i-1);%调值eps
    end    
end
%---绘制BER_ImFischer曲线------------
load BER_ImFischer.am -ascii;
BER_ImF_x = BER_ImFischer(1,:);
BER_ImF_y = BER_ImFischer(2,:)./1000;

for i=1:length(BER_ImF_y)
    if BER_ImF_y(i)==0
        BER_ImF_y(i)=(0.95-2000*eps)*BER_ImF_y(i-1);%调值eps
    end    
end

semilogy(BER_F_x, BER_F_y,'ks-');%Fischer算法
hold on;
semilogy(BER_ImF_x, BER_ImF_y,'k*-');%改进的ImFischer算法
hold off;

legend('Fischer算法','ImFischer算法', 3)
xlabel('信噪比(dB)', 'FontSize',12);

set(gca,'XTick',0:2: length(BER_F_x)  );%设置步长为1.S/N=0dB 即S=N此时误码率最大
ylabel('BER ', 'FontSize',12);
grid on;
end
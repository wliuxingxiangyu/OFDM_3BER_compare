function [ ]=ser_Fischer_compare()
load ser_Fischer.am -ascii;
ser_F_x = ser_Fischer(1,:);
ser_F_y = ser_Fischer(2,:);
ser_F_y


semilogy(ser_F_x, ser_F_y,'ks-');
hold off;

legend('FischerÀ„∑®', 3)
xlabel('–≈‘Î±»(dB)', 'FontSize',12);
set(gca,'XTick',0:1:(length(ser_F_x)+1)  );
ylabel('BER ', 'FontSize',12);
grid on;
end
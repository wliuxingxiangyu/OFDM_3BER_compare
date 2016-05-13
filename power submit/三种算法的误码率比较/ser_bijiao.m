function [ ]=ser_bijiao()
load  ser_16QAM_EP.am -ascii;
ser_16QAM_EP_x = ser_16QAM_EP(1,:);
ser_16QAM_EP_y = ser_16QAM_EP(2,:);

load ser_H.am -ascii;
ser_H_x = ser_H(1,:);
ser_H_y = ser_H(2,:);

load ser_F.am -ascii;
ser_F_x = ser_F(1,:);
ser_F_y = ser_F(2,:);

load  ser_chow.am -ascii;
ser_chow_x = ser_chow(1,:);
ser_chow_y = ser_chow(2,:);

semilogy(ser_16QAM_EP_x, ser_16QAM_EP_y,'kd-');
hold on;

semilogy(ser_H_x, ser_H_y,'k*-');
hold on;

semilogy(ser_F_x, ser_F_y,'k+-');
hold on;

semilogy(ser_chow_x, ser_chow_y,'ko-');
hold off;

legend('16QAM(EP) ', 'chow 算法','Fischer算法', 'Hughes-Hartogs算法',3)
xlabel('信噪比(dB)', 'FontSize',12);
ylabel('SER ', 'FontSize',12);
grid on;
end
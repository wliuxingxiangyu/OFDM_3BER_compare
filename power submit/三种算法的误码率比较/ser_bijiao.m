function [ ]=ser_bijiao()
load  ser_16QAM.am -ascii;
ser_16QAM_EP_x =ser_16QAM(1,:);
ser_16QAM_EP_y = ser_16QAM(2,:)./256;
ser_16QAM_EP_y 
load ser_Hughes.am -ascii;
ser_H_x = ser_Hughes(1,:);
ser_H_y = ser_Hughes(2,:)./256;
ser_H_y
load  ser_chow.am -ascii;
ser_chow_x = ser_chow(1,:);
ser_chow_y = ser_chow(2,:)./256;
ser_chow_y
load ser_Fischer.am -ascii;
ser_F_x = ser_Fischer(1,:);
ser_F_y = ser_Fischer(2,:)./2560;
ser_F_y
semilogy(ser_16QAM_EP_x, ser_16QAM_EP_y,'k>-');
hold on;

semilogy(ser_H_x, ser_H_y,'k*-');
hold on;

semilogy(ser_chow_x, ser_chow_y,'ko-');
hold on;

semilogy(ser_F_x, ser_F_y,'ks-');
hold off;

legend('16QAM(EP) ', 'Hughes-Hartogs算法','chow 算法','Fischer算法', 3)
xlabel('信噪比(dB)', 'FontSize',12);
ylabel('SER ', 'FontSize',12);
grid on;
end
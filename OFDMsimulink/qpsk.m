function [complex_signal_matrix]=qpsk(baseband_out)
%modulation of QPSK,modulate bitdata to QPSK complex signal
convert_matrix = reshape(baseband_out',2,length(baseband_out)/2)' ;%矩阵转换，每相邻2比特组成一个符号
modulo_baseband = bi2de(convert_matrix,'left-msb');%2500*1的十进制矩阵  即将每两个二进制符号转换为一个10进制数
carrier_matrix = reshape(modulo_baseband,carrier_count,symbols_per_carrier)';%生成 时间-载波25*100 矩阵 100个子载波  每个子载波上25个OFDM符号
carrier_matrix = [zeros(1,carrier_count); carrier_matrix];% 添加一个差分调制的初始相位
for i = 2:(symbols_per_carrier + 1) %从每个子载波的第一个符号开始调制
carrier_matrix(i,:) = rem(carrier_matrix(i,:) + carrier_matrix (i-1,:), 2^bits_per_symbol) ;% 差分调制 （差分编码）
end

carrier_matrix = carrier_matrix*((2*pi)/(2^bits_per_symbol));%相位映射 （0，0）=0 -->0;  (0,1)=1 -->90;  (1,0)=2-->180;     (1,1)=3  -->270
[X, Y]=pol2cart(carrier_matrix, ones(size(carrier_matrix,1),size(carrier_matrix,2))); % 由极坐标向复数坐标转化 第一参数为相位 第二参数为幅度  幅度均为1
complex_signal_matrix = complex(X, Y);
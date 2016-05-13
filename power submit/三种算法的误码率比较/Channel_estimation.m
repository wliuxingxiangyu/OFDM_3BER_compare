%------------Ideal Channel estimation--------------
function [H_ideal channel_impulse]=Channel_estimation(path_delay,path_amp_average,Num_subc)
%----------------------Input---------------------------------------------------
% in_channel:out_GIinsert
% LengthOfBurst: the length of one processing period depend on not only
%                frame length but only oversamping rate
% NumOfTaps:Length of channel impulse response信道冲激响应的长度＝抽头长度
% Path_Delay: Channel taps' delay
% Path_Average_Power:Channel taps'average power
% NumOfAntennas: Number of transmission antennas
%-------------------------------------------------------------------------
% Output:
% OutData: the siganl which has passed through the multipath channel
% Fading_Weight: Channel Impulse Response
%-------------------------------------------------------------------------
path_length=length(path_delay);
    % Generate fading weight
    Init_channel_impulse=(randn(1,path_length)+j*randn(1,path_length)).*path_amp_average/sqrt(2);
    % Re-sorted according to the path delay
    %Fading_Weight(ant,:) = zeros(1,Max_Delay);
    channel_impulse=[];
    for k=1:path_length
          channel_impulse(path_delay(k)+1)=Init_channel_impulse(k);
    end
H_ideal=fft(channel_impulse,Num_subc);
end




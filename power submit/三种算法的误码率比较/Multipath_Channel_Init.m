%------------Multipath_Rayleigh channel--------------
function [path_delay,path_amp_average]=Multipath_Channel_Init(rms_delay,max_delay,num_taps)
%-------------------Input---------------------------
% rms_delay: RMS path delay时延扩展
% max_delay: Maximum path delay最大时延扩展
% num_taps: Number of taps per multipath channel 多径数
%--------------------------Output--------------------------------------
% path_delay: The delay values of different paths
% path_amp_average: The amplitude values of different paths 
%-----------Initialization of parameters for fading generating-----------
Init_delay_flag=1;
while Init_delay_flag>0
  absolute_path_delay=floor(rand(1,num_taps)*max_delay);       % Path Delay 
  path_delay=sort(absolute_path_delay)-min(absolute_path_delay);   %排序
  Init_delay_flag=0;
  %---------Check whether two path delay values are same-------------
  path_delay_diff=diff(path_delay);
  for i=1:num_taps-1
    if(path_delay_diff(i)==0)
       %error('Two path delay values are same!'); 
       Init_delay_flag=1;
    end
  end
end
%-------------------------------------------------------------------------
% compute the power of each tap according to a exponetial(指数) distribution
%-------------------------------------------------------------------------
path_power_average=exp((-1)*path_delay/rms_delay);  %路径平均功率
%-------------------------------------------------------------------------
% Scale tap powers to total power 1.0 and convert to amplitudes 归一化 标称化
%-------------------------------------------------------------------------
sum_power=sum(path_power_average);                     % unify the power
scaled_path_power_average=path_power_average/sum_power;
path_amp_average=sqrt(scaled_path_power_average);              % the amplitude of each tap

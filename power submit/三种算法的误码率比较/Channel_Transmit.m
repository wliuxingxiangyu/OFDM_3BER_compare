%-----------------------Multipath_Channel Transmission-----------
%---------------改动：将线性卷积变成圆周卷积－－－－－－－－－
function out_channel=Channel_Transmit(out_GIinsert,channel_impulse)
    % get the output data of each independent channel
    L=length(out_GIinsert);
    response=cconv(out_GIinsert,channel_impulse,L);%conv->cconv(,,)
    out_channel=response;
end 
 



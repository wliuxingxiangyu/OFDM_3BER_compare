%-----------------------Multipath_Channel Transmission-----------
%---------------�Ķ��������Ծ�����Բ�ܾ��������������������
function out_channel=Channel_Transmit(out_GIinsert,channel_impulse)
    % get the output data of each independent channel
    L=length(out_GIinsert);
    response=cconv(out_GIinsert,channel_impulse,L);%conv->cconv(,,)
    out_channel=response;
end 
 



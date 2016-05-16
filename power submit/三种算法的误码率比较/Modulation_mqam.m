%-----------------------MQAM Modulation Module---------------
function out_modulated=Modulation_mqam(bit_sub,power_sub,bitnum_sub)
%---------------------------
load MQAM_space.mat
num_sub=size(bit_sub,1);%bit_sub维数64*8,num_sub=64
out_modulated=zeros(num_sub,1);%out_modulated维数64*1
%------------------------------
for i=1:num_sub
    switch bitnum_sub(i)
        case 0
            ;
        case 1
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam2(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 2
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam4(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 3  %分配3bit用qam8
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam8(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 4  %分配4bit用qam16
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;%二进制转十进制dec_data
            map_data=qam16(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 5
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam32(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 6
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam64(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 7
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam128(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        case 8
            dec_data=bi2de(bit_sub(i,1:bitnum_sub(i)),'left-msb')+1;
            map_data=qam256(dec_data)*sqrt(power_sub(i));
            out_modulated(i)=map_data;
        otherwise
            error('Number of bits allocated for the subcarrier out of bounds!')
    end
end
end

    
            
            
            
            
            
            
            
            
   
            
    

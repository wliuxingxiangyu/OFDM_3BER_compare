%-----------------------MQAM Demodulation Module---------------
function out_demodulated=Demodulation_mqam(out_ideal,bitnum_sub,power_sub,M)
load Code_bit.mat
load MQAM_space.mat
num_sub=length(bitnum_sub);
out_demodulated=zeros(num_sub,M);
for i=1:num_sub
     switch bitnum_sub(i)
        case 0
            ;
        case 1
            diff=abs(qam2-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code2(dec_data,:);
        case 2
            diff=abs(qam4-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code4(dec_data,:);
        case 3
            diff=abs(qam8-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code8(dec_data,:);
        case 4
            diff=abs(qam16-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code16(dec_data,:);
        case 5
            diff=abs(qam32-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code32(dec_data,:);
        case 6
            diff=abs(qam64-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code64(dec_data,:);
        case 7
            diff=abs(qam128-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code128(dec_data,:);
        case 8
            diff=abs(qam256-1/sqrt(power_sub(i))*out_ideal(i));
            dec_data=find(diff==min(diff),1);
            out_demodulated(i,1:bitnum_sub(i))=code256(dec_data,:);
         otherwise
             error('Number of bits allocated for the subcarrier out of bounds!')
     end
end
end

            
            
            
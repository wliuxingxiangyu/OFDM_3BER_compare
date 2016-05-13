%------Source Allocation<<<<-=->>>>Serial to Parallel Conversion------
function [bitnum_sub,power_sub]=Resource_alloc(Num_subc,gain_subc,Rt,gap,Noise_var,M,BER_target,Pt,xia,B)
%-----------------------input variables----------------------

%------------------------initialization----------------------
%------------------------------------------------------
flag=1;
while flag
    switch xia
        case 0.1
            [bit_alloc power_alloc]=EBA_EPA(Pt,B,Num_subc,gain_subc,Noise_var,gap,Rt);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        case 0.2
            [bit_alloc power_alloc]=MaxC_EPA(Pt,Num_subc,gain_subc,Noise_var,gap,Rt,M);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        case 1
            [bit_alloc power_alloc]=waterfill(Num_subc,Pt,gain_subc,Noise_var,gap,B,M,Rt);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        case 2
            snr_sub=SNR_sub(gain_subc,Noise_var/78125,gap);
            [bit_alloc power_alloc]=chow_algo(snr_sub,Num_subc,gap,Rt);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        case 3
            [bit_alloc,power_alloc]=Hughes_Hartogs(Num_subc,Rt,M,BER_target,Noise_var,gain_subc);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        case 4
            [bit_alloc power_alloc]=Fischer(Num_subc,Rt,Pt,gain_subc);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc;
            flag=0;
        case 5
            [bit_alloc power_alloc]=Algo_xia(Num_subc,Pt,M,gain_subc,gap,Noise_var,Rt);
            bitnum_sub=bit_alloc;
            power_sub=power_alloc./sum(power_alloc).*Pt;
            flag=0;
        otherwise
            diap('The number is invalid,Please enter again£¡');
            x=input('Number=');
            flag=1;
    end
end
end

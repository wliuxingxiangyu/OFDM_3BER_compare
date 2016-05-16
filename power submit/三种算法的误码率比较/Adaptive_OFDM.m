%Introduce:仿真平台可以分为16个模块，其中模块1～模块15，各用一个函数实现其功能；
%信道建立未考虑多普勒频移；信道估计为理想估计；采用子载波平均信噪比，子载波平均功率归一化为1。
%系统发送比特总数固定，为Rt.
clear all; clc;
%% --------------------Parameters----------
Num_subc=64;
% Rb=10e6;  %(bit/s) 10Mbit/s
P_av=1;
SNR_av=0:2:30;%子载波平均信噪比
Noise_var=P_av./10.^(SNR_av./10); %子载波噪声功率
Pt=P_av*Num_subc; %energy (wat????)
Rb=10e6; % in Mbit/s
MaxBitPerCarrier=8;       %max number of bit for per subcarrier
Rt=256;   %bit/OFDMsymbol;
B=5e6;    %(Hz) 5MHz
B_subc=B/Num_subc; %子载波带宽78.125kHz
BER_target=1e-4;%BER_target仅用于Hughes_Hartogs算法
gap=-log(5*BER_target)/1.5;  %dB
% Eb=Pt/Rt; %average energy of per bit   1/128(wat)
% Eb_N0=0:2:20;  %SNR per bit
% Noise_var =Eb./10.^(Eb_N0./10); %PSD of noise in different SNR   % average power of noise in per subcarrier
numSNR=length(SNR_av); %信噪比的取值个数
rms_delay=2;  %rms时延扩展
max_delay=16; %最大时延扩展
num_taps=4;  %多径数
GI_length=8; %length of GI
BER_stat=zeros(1,length(SNR_av)); %统计BER
Total_error=zeros(1,length(SNR_av)); %总错误比特数
Max_counter=1;  %在一个信噪比取值下，进行Max_counter次发送和接收，来统计：平均BER
%% -----改动参数--
loadFileFlag=0;
structStorePathStr='./structStore.mat';
structStoreNoisePathStr='./structStoreNoise.mat';
%% --------------------------------------------------------------------
% for algoMode=1:5  %k：选择算法的次数/程序运行次数/信道建立次数
for algoMode=4  %k：选择算法的次数/程序运行次数/信道建立次数
    %-----------Select parameter for Resource Allocation Algo----------------
    %模块0：选择algorthm Mode
    for i=1:numSNR %信噪比的取值个数
        %  disp('Please wait......');
        %         loop=i
        for loop=1:Max_counter
            %% *******发射系统*******
            if loadFileFlag==0  %不是从文件加载
                %模块1：多径瑞利衰落信道建立，返回信道频率响应和冲激响应
                [path_delay path_amp_average]=Multipath_Channel_Init(rms_delay,max_delay,num_taps);
                [H_ideal channel_impulse]=Channel_estimation(path_delay,path_amp_average,Num_subc);
                gain_subc=abs(H_ideal);
                %模块2:比特功率分配部分，
                % H_normalized=H_ideal./sum(abs(H_ideal));
                % gain_subc=abs(H_normalized);
                [bitnum_sub power_sub]=Resource_alloc(Num_subc,gain_subc,Rt,gap,...
                    Noise_var(i),MaxBitPerCarrier,BER_target,Pt,algoMode,B);%BER_target仅用于Hughes_Hartogs算法
                % Bit_total=sum(bitnum_sub);
                %模块3：发送比特产生
                Bit_sequence=randi(1,Rt);%需固定
                %                 %模块9：加性高斯噪声
                %                 out_AWGN=Gngauss(Noise_var(i),out_channel);%有randn噪声
                %---------存入文件---
                structTemp=[];
                structTemp.H_ideal=H_ideal;
                structTemp.channel_impulse=channel_impulse;
                structTemp.bitnum_sub=bitnum_sub;
                structTemp.power_sub=power_sub;
                structTemp.Bit_sequence=Bit_sequence;
                save(structStorePathStr, '-struct', 'structTemp');
            else   %是从文件加载
                structTemp=load(structStorePathStr);
                H_ideal=structTemp.H_ideal;
                channel_impulse=structTemp.channel_impulse;
                bitnum_sub=structTemp.bitnum_sub;
                power_sub=structTemp.power_sub;
                Bit_sequence=structTemp.Bit_sequence;
            end;
            %模块4：串并转换
            bit_sub=StoP_convert(Bit_sequence,bitnum_sub,MaxBitPerCarrier);
            %--------------Modulation(MQAM)---------------
            %模块5：调制部分，选择MQAM调制方式
            out_modulated=Modulation_mqam(bit_sub,power_sub,bitnum_sub);
            %------------------IFFT-------------------------
            %模块6：IFFT将信号变换到时域
            out_IFFT=sqrt(Num_subc).*ifft(out_modulated);
            %-----------------GI(Gurad Interval) Insertion--
            %模块7：保护间隔插入
            out_GIinsert=GI_insert(out_IFFT,GI_length);
            %-------------------Multipath Channel Transmission-------
            %模块8：多径信道响应
            out_channel=Channel_Transmit(out_GIinsert,channel_impulse);
            %---------------------AWGN Addition---------------
            %+++++++++++++++++++++compute noise_var+++++++++???????
            %--------------------------------------------------
            %模块9：加性高斯噪声
            if loadFileFlag==0  %不是从文件加载
                Length=length(out_channel);
                Noise_complex=sqrt(Noise_var).*(randn(1,Length)+j.*randn(1,Length));
                out_AWGN=out_channel+Noise_complex;
                structNoise.Noise_complex=Noise_complex;
                save(structStoreNoisePathStr, '-struct', 'structNoise');
            else %是从文件加载
                 Length=length(out_channel);
                 structNoise=load(structStoreNoisePathStr); 
                Noise_complex=structNoise.structNoise;
                out_AWGN=out_channel+Noise_complex;          
            end
            %% *******接收系统*********************
            %------------------GI(Gurad Interval) Remove-------
            %模块10：保护间隔去除
            out_GIremove=out_AWGN(GI_length+1:length(out_AWGN));
            %-----------------------FFT--------------------
            %模块11：FFT将信号变换到频域
            out_FFT=1/sqrt(Num_subc).*fft(out_GIremove);
            %---------------------------Ideal Receive Estimation-------
            %模块12：理想接收，信道估计为理想状态，未加入信道估计算法
            out_ideal=Receive_estimation(out_FFT,H_ideal);
            %-----------Demodulation<<<<-->>>>-----------------
            %模块13：解调部分
            out_demodulated=Demodulation_mqam(out_ideal,bitnum_sub,power_sub,MaxBitPerCarrier);
            %--------------Parallel to Serial Conversion--------
            %模块14：并串转换
            Rx_sequence=PtoS_convert(out_demodulated,bitnum_sub,Rt);
            %--------------------------- BER Calculation--------------
            %模块15：BER统计
            [BER_oneloop Num_error]=BER_calculation(Bit_sequence,Rx_sequence);
            BER_stat(i)=BER_stat(i)+BER_oneloop;%BER_oneloop:一次循环的BER
            Total_error(i)=Total_error(i)+Num_error;%错误的比特数
        end
        %Max_counter次循环已结束
        BER_stat(i)=BER_stat(i)/Max_counter;%Average_error平均BER
        Average_error(i)=Total_error(i)/Max_counter;%Average_error平均错误的比特数
    end% 第i个SNR计算已结束
    %--------------------------Plot------------------
    %模块16：BER曲线绘图 %存入各自BER   am文件
    data=[];
    data = [SNR_av; BER_stat];%两个1*16拼接成2*16
    if algoMode == 1
        save ser_16QAM.am data -ascii;
    elseif  algoMode == 2
        save ser_chow.am   data -ascii;
    elseif  algoMode == 3
        save ser_Hughes.am       data -ascii;
    elseif  algoMode == 4
        save ser_Fischer.am      data -ascii;
    end
end %第algoMode种算法已结束
% ser_bijiao();%几种绘图
ser_Fischer_compare();
%-------------------end of file------------------------------
%Introduce:����ƽ̨���Է�Ϊ16��ģ�飬����ģ��1��ģ��15������һ������ʵ���书�ܣ�
%�ŵ�����δ���Ƕ�����Ƶ�ƣ��ŵ�����Ϊ������ƣ��������ز�ƽ������ȣ����ز�ƽ�����ʹ�һ��Ϊ1��
%ϵͳ���ͱ��������̶���ΪRt.
clear all; clc;
%% --------------------Parameters----------
Num_subc=64;
% Rb=10e6;  %(bit/s) 10Mbit/s
P_av=1;
SNR_av=0:2:30;%���ز�ƽ�������
Noise_var=P_av./10.^(SNR_av./10); %���ز���������
Pt=P_av*Num_subc; %energy (wat????)
Rb=10e6; % in Mbit/s
MaxBitPerCarrier=8;       %max number of bit for per subcarrier
Rt=256;   %bit/OFDMsymbol;
B=5e6;    %(Hz) 5MHz
B_subc=B/Num_subc; %���ز�����78.125kHz
BER_target=1e-4;%BER_target������Hughes_Hartogs�㷨
gap=-log(5*BER_target)/1.5;  %dB
% Eb=Pt/Rt; %average energy of per bit   1/128(wat)
% Eb_N0=0:2:20;  %SNR per bit
% Noise_var =Eb./10.^(Eb_N0./10); %PSD of noise in different SNR   % average power of noise in per subcarrier
numSNR=length(SNR_av); %����ȵ�ȡֵ����
rms_delay=2;  %rmsʱ����չ
max_delay=16; %���ʱ����չ
num_taps=4;  %�ྶ��
GI_length=8; %length of GI
BER_stat=zeros(1,length(SNR_av)); %ͳ��BER
Total_error=zeros(1,length(SNR_av)); %�ܴ��������
Max_counter=1;  %��һ�������ȡֵ�£�����Max_counter�η��ͺͽ��գ���ͳ�ƣ�ƽ��BER
%% -----�Ķ�����--
loadFileFlag=0;
structStorePathStr='./structStore.mat';
structStoreNoisePathStr='./structStoreNoise.mat';
%% --------------------------------------------------------------------
% for algoMode=1:5  %k��ѡ���㷨�Ĵ���/�������д���/�ŵ���������
for algoMode=4  %k��ѡ���㷨�Ĵ���/�������д���/�ŵ���������
    %-----------Select parameter for Resource Allocation Algo----------------
    %ģ��0��ѡ��algorthm Mode
    for i=1:numSNR %����ȵ�ȡֵ����
        %  disp('Please wait......');
        %         loop=i
        for loop=1:Max_counter
            %% *******����ϵͳ*******
            if loadFileFlag==0  %���Ǵ��ļ�����
                %ģ��1���ྶ����˥���ŵ������������ŵ�Ƶ����Ӧ�ͳ弤��Ӧ
                [path_delay path_amp_average]=Multipath_Channel_Init(rms_delay,max_delay,num_taps);
                [H_ideal channel_impulse]=Channel_estimation(path_delay,path_amp_average,Num_subc);
                gain_subc=abs(H_ideal);
                %ģ��2:���ع��ʷ��䲿�֣�
                % H_normalized=H_ideal./sum(abs(H_ideal));
                % gain_subc=abs(H_normalized);
                [bitnum_sub power_sub]=Resource_alloc(Num_subc,gain_subc,Rt,gap,...
                    Noise_var(i),MaxBitPerCarrier,BER_target,Pt,algoMode,B);%BER_target������Hughes_Hartogs�㷨
                % Bit_total=sum(bitnum_sub);
                %ģ��3�����ͱ��ز���
                Bit_sequence=randi(1,Rt);%��̶�
                %                 %ģ��9�����Ը�˹����
                %                 out_AWGN=Gngauss(Noise_var(i),out_channel);%��randn����
                %---------�����ļ�---
                structTemp=[];
                structTemp.H_ideal=H_ideal;
                structTemp.channel_impulse=channel_impulse;
                structTemp.bitnum_sub=bitnum_sub;
                structTemp.power_sub=power_sub;
                structTemp.Bit_sequence=Bit_sequence;
                save(structStorePathStr, '-struct', 'structTemp');
            else   %�Ǵ��ļ�����
                structTemp=load(structStorePathStr);
                H_ideal=structTemp.H_ideal;
                channel_impulse=structTemp.channel_impulse;
                bitnum_sub=structTemp.bitnum_sub;
                power_sub=structTemp.power_sub;
                Bit_sequence=structTemp.Bit_sequence;
            end;
            %ģ��4������ת��
            bit_sub=StoP_convert(Bit_sequence,bitnum_sub,MaxBitPerCarrier);
            %--------------Modulation(MQAM)---------------
            %ģ��5�����Ʋ��֣�ѡ��MQAM���Ʒ�ʽ
            out_modulated=Modulation_mqam(bit_sub,power_sub,bitnum_sub);
            %------------------IFFT-------------------------
            %ģ��6��IFFT���źű任��ʱ��
            out_IFFT=sqrt(Num_subc).*ifft(out_modulated);
            %-----------------GI(Gurad Interval) Insertion--
            %ģ��7�������������
            out_GIinsert=GI_insert(out_IFFT,GI_length);
            %-------------------Multipath Channel Transmission-------
            %ģ��8���ྶ�ŵ���Ӧ
            out_channel=Channel_Transmit(out_GIinsert,channel_impulse);
            %---------------------AWGN Addition---------------
            %+++++++++++++++++++++compute noise_var+++++++++???????
            %--------------------------------------------------
            %ģ��9�����Ը�˹����
            if loadFileFlag==0  %���Ǵ��ļ�����
                Length=length(out_channel);
                Noise_complex=sqrt(Noise_var).*(randn(1,Length)+j.*randn(1,Length));
                out_AWGN=out_channel+Noise_complex;
                structNoise.Noise_complex=Noise_complex;
                save(structStoreNoisePathStr, '-struct', 'structNoise');
            else %�Ǵ��ļ�����
                 Length=length(out_channel);
                 structNoise=load(structStoreNoisePathStr); 
                Noise_complex=structNoise.structNoise;
                out_AWGN=out_channel+Noise_complex;          
            end
            %% *******����ϵͳ*********************
            %------------------GI(Gurad Interval) Remove-------
            %ģ��10���������ȥ��
            out_GIremove=out_AWGN(GI_length+1:length(out_AWGN));
            %-----------------------FFT--------------------
            %ģ��11��FFT���źű任��Ƶ��
            out_FFT=1/sqrt(Num_subc).*fft(out_GIremove);
            %---------------------------Ideal Receive Estimation-------
            %ģ��12��������գ��ŵ�����Ϊ����״̬��δ�����ŵ������㷨
            out_ideal=Receive_estimation(out_FFT,H_ideal);
            %-----------Demodulation<<<<-->>>>-----------------
            %ģ��13���������
            out_demodulated=Demodulation_mqam(out_ideal,bitnum_sub,power_sub,MaxBitPerCarrier);
            %--------------Parallel to Serial Conversion--------
            %ģ��14������ת��
            Rx_sequence=PtoS_convert(out_demodulated,bitnum_sub,Rt);
            %--------------------------- BER Calculation--------------
            %ģ��15��BERͳ��
            [BER_oneloop Num_error]=BER_calculation(Bit_sequence,Rx_sequence);
            BER_stat(i)=BER_stat(i)+BER_oneloop;%BER_oneloop:һ��ѭ����BER
            Total_error(i)=Total_error(i)+Num_error;%����ı�����
        end
        %Max_counter��ѭ���ѽ���
        BER_stat(i)=BER_stat(i)/Max_counter;%Average_errorƽ��BER
        Average_error(i)=Total_error(i)/Max_counter;%Average_errorƽ������ı�����
    end% ��i��SNR�����ѽ���
    %--------------------------Plot------------------
    %ģ��16��BER���߻�ͼ %�������BER   am�ļ�
    data=[];
    data = [SNR_av; BER_stat];%����1*16ƴ�ӳ�2*16
    if algoMode == 1
        save ser_16QAM.am data -ascii;
    elseif  algoMode == 2
        save ser_chow.am   data -ascii;
    elseif  algoMode == 3
        save ser_Hughes.am       data -ascii;
    elseif  algoMode == 4
        save ser_Fischer.am      data -ascii;
    end
end %��algoMode���㷨�ѽ���
% ser_bijiao();%���ֻ�ͼ
ser_Fischer_compare();
%-------------------end of file------------------------------
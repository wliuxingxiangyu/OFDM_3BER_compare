%Introduce:����ƽ̨���Է�Ϊ16��ģ�飬����ģ��1��ģ��15������һ������ʵ���书�ܣ�
%�ŵ�����δ���Ƕ�����Ƶ�ƣ��ŵ�����Ϊ������ƣ��������ز�ƽ������ȣ����ز�ƽ�����ʹ�һ��Ϊ1��
%ϵͳ���ͱ��������̶���ΪRt.
clear all;
clc;
%--------------------------------------------
%--------------------Parameters----------
Num_subc=64;
% Rb=10e6;  %(bit/s) 10Mbit/s
P_av=1;
SNR_av=0:2:30;%���ز�ƽ�������
Noise_var=P_av./10.^(SNR_av./10); %���ز���������
Pt=P_av*Num_subc; %energy (wat????)
Rb=10e6; % in Mbit/s
M=8;       %max number of bit for per subcarrier
Rt=256;   %bit/OFDMsymbol;
B=5e6;    %(Hz) 5MHz
B_subc=B/Num_subc; %78.125kHz
BER_target=1e-4;
gap=-log(5*BER_target)/1.5;  %dB
% Eb=Pt/Rt; %average energy of per bit   1/128(wat)
% Eb_N0=0:2:20;  %SNR per bit
% Noise_var =Eb./10.^(Eb_N0./10); %PSD of noise in different SNR   % average power of noise in per subcarrier
L=length(SNR_av); %����ȵ�ȡֵ����
rms_delay=2;  %rmsʱ����չ
max_delay=16; %���ʱ����չ
num_taps=4;  %�ྶ��
GI_length=8; %length of GI
BER_stat=zeros(1,length(SNR_av)); %ͳ��BER
Total_error=zeros(1,length(SNR_av)); %�ܴ��������
Max_counter=800;  %��һ�������ȡֵ�£�����800�η��ͺͽ��գ���ͳ��BER
%--����---------------Multipath_Rayleigh Channel Establish------
%ģ��1���ྶ����˥���ŵ������������ŵ�Ƶ����Ӧ�ͳ弤��Ӧ
[path_delay path_amp_average]=Multipath_Channel_Init(rms_delay,max_delay,num_taps);
[H_ideal channel_impulse]=Channel_estimation(path_delay,path_amp_average,Num_subc);
gain_subc=abs(H_ideal)
% load  inf/inf3.mat
%--------------------------------------------------------------------
for k=1:1  %k��ѡ���㷨�Ĵ���/�������д���/�ŵ���������
    %-----------Select parameter for Resource Allocation Algo----------------
    %ģ��0����������������
    disp('Please input number to select the program you want to execute.');
    disp('0.1   EBA_EPA Algorithm');
    disp('0.2   MaxC_EPA Algorithm');
    disp('1   Waterfilling Algorithm');
    disp('2   Chow Algorithm');   %???????
    disp('3   Hughes-Hartogs Algorithm');
    disp('4   Fischer Algorithm');
    disp('5   Algo_xia Algorithm');
    xia=input('Number=');
    %*************************************Tx****����ϵͳ*************************
    for i=1:L
        disp('Please wait......');
        loop=i
        for loop=1:Max_counter
            %------Source Allocation<<<<-->>>>-----------------
            %ģ��2:���ع��ʷ��䲿�֣�ͨ��ģ��0ѡ��Ҫִ�е�����Ӧ�����㷨
            % H_normalized=H_ideal./sum(abs(H_ideal));
            % gain_subc=abs(H_normalized);
            [bitnum_sub power_sub]=Resource_alloc(Num_subc,gain_subc,Rt,gap,Noise_var(i),M,BER_target,Pt,xia,B);
            % Bit_total=sum(bitnum_sub);
            %========================>>>Data Generation>>>>>===================
            %ģ��3�����ͱ��ز���
            Bit_sequence=randi(1,Rt);
            % Bit_sequence=randi(1,Bit_total);
            %-----------------Serial to Parallel Conversion------
            %ģ��4������ת��
            bit_sub=StoP_convert(Bit_sequence,bitnum_sub,M);
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
            %ģ��9�������˹������
            out_AWGN=Gngauss(Noise_var(i),out_channel);
            %****************************Rx*********����ϵͳ*********************
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
            out_demodulated=Demodulation_mqam(out_ideal,bitnum_sub,power_sub,M);
            %--------------Parallel to Serial Conversion--------
            %ģ��14������ת��
            Rx_sequence=PtoS_convert(out_demodulated,bitnum_sub,Rt);
            %--------------------------- BER Calculation--------------
            %ģ��15��BERͳ��
            [BER_oneloop Num_error]=BER_calculation(Bit_sequence,Rx_sequence);
            BER_stat(i)=BER_stat(i)+BER_oneloop;
            Total_error(i)=Total_error(i)+Num_error;
        end
        BER_stat(i)=BER_stat(i)/Max_counter;
        Average_error(i)=Total_error(i)/Max_counter;
    end
    BER_stat
    Average_error
    %------------------------------------------------------
    % save c:\matlab\Adaptive_OFDM_vSimple_Alpha\inf\Inf_simulation.mat gain_subc channel_impulse H_ideal BER_stat;
    %--------------------------Plot------------------
    %ģ��16��BER���߻�ͼ
    semilogy(SNR_av,BER_stat,'o-r');
    data = [SNR_av; BER_stat];
    save ser_16QAM_EP.am data -ascii;
    % plot(SNR_av,BER_stat,'*-r');
    grid on;
end
%-------------------end of file------------------------------



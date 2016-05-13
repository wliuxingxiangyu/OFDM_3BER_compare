%--------------------------- BER_oneloop Calculation----------------
function [BER_oneloop Num_error]=BER_calculation(Bit_sequence,Rx_sequence)
%------------Initialization-----------------
Num_ErrorBit=0;
%------------------------------------------
for i=1:length(Bit_sequence)
    if Rx_sequence(i)~=Bit_sequence(i);
        Num_ErrorBit=Num_ErrorBit+1;
    end
end
BER_oneloop=Num_ErrorBit/length(Bit_sequence);
Num_error=Num_ErrorBit;
end


    
        

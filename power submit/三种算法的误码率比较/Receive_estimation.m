%---------------------Receive_estimation---------------
function out_ideal=Receive_estimation(out_FFT,H_ideal)
Conj_H_ideal=conj(H_ideal);
Module2_H=(Conj_H_ideal.*H_ideal);
out_ideal=out_FFT.*Conj_H_ideal./Module2_H;
end

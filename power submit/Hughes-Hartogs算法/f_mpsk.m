%function power=f_mpsk(b,Pe,N_psd)
%-----------------------------------
%Programmed by Xia zhaokang
%May-21-2009
%-----------------------------------
function power=f_mpsk(b,Pe,N_psd)
switch b
    case 0
        power=0;
    case 1
        power=N_psd/2*(Qinv(Pe))^2;
    case 2
        power=N_psd*(Qinv(1-sqrt(1-Pe)))^2;
    otherwise
        power=N_psd/2*(Qinv(Pe/2)/sin(pi/2^b))^2;
end

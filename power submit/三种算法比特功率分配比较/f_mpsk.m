%function power=f_mpsk(b,Pe,N_psd)
%-----------------------------------
%Programmed by Xia zhaokang
%May-21-2009
%-----------------------------------
function power=f_mpsk(b,Pe,N_psd)
power=zeros(1,length(b));
for i=1:length(b)
switch b(i)
    case 0
        power(i)=0;
    case 1
        power(i)=N_psd/2*(Qinv(Pe))^2;
    case 2
        power(i)=N_psd*(Qinv(1-sqrt(1-Pe)))^2;
    otherwise
        power(i)=N_psd/2*(Qinv(Pe/2)/sin(pi/2^b(i)))^2;
end
end

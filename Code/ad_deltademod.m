function [rec_xq,signal] = ad_deltademod(c,zero_flag_array,delta_min)

%This is a adaptive delta demodulator

L = length(c);

signal = zeros(1,L);
rec_delta_array = zeros(1,L);
sign_array = zeros(1,L);
rec_xq = zeros(1,L);

%first we need to generate our error/sign array

for i = 1:L
    if c(i) == 0
        sign_array(i) = -1;
    else
        sign_array(i) = 1;
    end
    
    if zero_flag_array(i) == 1
        sign_array(i) = 0;
    end
    
end

for i = 1:L
        if(i==1)
            if(sign_array(i) == 0)
                rec_delta_array(i) = delta_min;
            else
                rec_delta_array(i) = delta_min*sign_array(i);
            end
            
            rec_xq(i) = rec_delta_array(i);
            signal(i) = rec_xq(i);
        else
            rec_delta_array(i) = (abs(rec_delta_array(i-1))*sign_array(i)) + (rec_delta_array(1)*sign_array(i-1));
            rec_xq(i) = rec_delta_array(i) + rec_xq(i-1);
            signal(i) = signal(i-1) + rec_xq(i);
        end
end

end
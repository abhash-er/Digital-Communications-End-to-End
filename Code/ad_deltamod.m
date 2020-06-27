function [c,xq,zero_flag_array] = ad_deltamod(x,delta_min)

%This is a Adaptive delta Modulator


%{
x -> The signal input,a vector
delta_min -> min step size 
zero_flag_array -> zero indicator to avoid zero error
c -> encoded digital output 
%}


    N = length(x);
    delta_array = zeros(1,N); %variable delta
    e = zeros(1,N);           %error
    eq = zeros(1,N);          %quantized error
    xq = zeros(1,N);            

    %zero_flag
    zero_flag_array = zeros(1,N);


    for i = 1:N
        if x(i) == 0
            zero_flag_array(i) = 1; 
        end
    end


    for i = 1:length(x)
            if(i==1)
                e(i) = x(i);

                if x(i) == 0
                    delta_array(i) = delta_min;
                else
                    delta_array(i) = delta_min*sign(e(i));
                end

                eq(i) = delta_array(i);
                xq(i) = eq(i);
            else
                e(i) = x(i) - xq(i-1);
                delta_array(i) = (abs(delta_array(i-1))*sign(e(i))) + (delta_array(1)*sign(e(i-1)));
                %delta_array(i) = delta_min*sign(e(i));
                eq(i) = delta_array(i);
                xq(i) = eq(i) + xq(i-1);
            end

    end

    c = ones(1,N);
    for i = 1:N
        if e(i)>0
            %only positive vals
            c(i) = 1;
        else
            %-ve + 0
            c(i) = 0;
        end
    end

end

    
    
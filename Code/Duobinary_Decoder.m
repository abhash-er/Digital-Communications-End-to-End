function [b_out] = Duobinary_Decoder(c)

%This is a precoded binary decoder
%c is the duobinary coded output
%b_out is the output of suobinary decoder


% decoder decision
b_out = zeros(1,length(c));
for k =1:length(c)
  if(abs(c(k)) > 1)
    b_out(k) =  0;
  else
    b_out(k) = 1;
  end
end


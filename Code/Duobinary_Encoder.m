function [c] = Duobinary_Encoder(b)

%This is a precoded duobinary encoder
%b is the input binary sequence : precoded input
% a_volts is basically the NRZ encoder output
%c is the duobinary coded output

%variables
a = zeros(1,length(b));
a_volts = zeros(1,length(b));
a(1) = xor(1,b(1));


%NRZ Encoder for converting bits to voltage levels
if(a(1) == 1)
    a_volts(1) = 1;
else
    a_volts(1) = -1;
end

for k = 2:length(b)
    a(k) = xor(a(k-1),b(k));
    if(a(k) == 1)
        a_volts(k) = 1;
    else
        a_volts(k) = -1;
    end
end

disp('Precoded output in binary:');
disp(a);
disp('..................................................................');
disp('Precoded output in voltage:');
disp(a_volts);
disp('..................................................................');

%Encoder
c = zeros(1,length(b));
c(1) = 1 + a_volts(1);

for k = 2:length(a)
    c(k) = a_volts(k-1) + a_volts(k);
end
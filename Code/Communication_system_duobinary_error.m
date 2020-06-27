clear all;
close all;
clc;


Am = 1;      %amplitude            %input('Enter the value for amplitude');
fm = 1;      %frequency            %input('Enter the value for frequency');
fs = 15*fm;  %sampling freq        %input('What is the sampling frequency?');

t = 0:1/fs:1;

%input signal
x = Am*sin(2*pi*fm*t); 

delta = (2*pi*fm*Am)/fs;



[digital_code,xq,zero_track] = ad_deltamod(x,delta);                                 %Transmittor
disp('The digital code is:');
disp(digital_code);
disp(' ');

coded = Duobinary_Encoder(digital_code);                                             %duobinary_encoder
disp(' ');
disp('Encoded digital code is:');
disp(coded);
disp(' ');

coded = awgn(coded,-20);

decoded_digital_code = Duobinary_Decoder(coded);                                     %duobinary_decoder
disp('The output of duobinary decoder is');
disp(decoded_digital_code);
disp(' ');

[rec_staircase,my_signal] = ad_deltademod(decoded_digital_code,zero_track,delta);    %Reciever

y = lowpass(my_signal,1,fs);   


error = xor(decoded_digital_code,digital_code);
disp(' ');
disp('error');
disp(error);

figure('Name','Adaptive Delta Modulation(Noise at Duo-binary Encoder)','NumberTitle','off');
plot(t,x,'DisplayName','Message signal');
title('Adaptive Delta Modulation');
xlabel('Time (in sec)');
ylabel('Amplitude (in volts)');
hold 'on';
stairs(t,xq,'DisplayName','Staircase signal');
stairs(t,rec_staircase,'DisplayName','Recieved Staircase signal at reciever');
plot(t,y,'DisplayName','Recieved signal');
hold 'off';
legend


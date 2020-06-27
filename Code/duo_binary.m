%>>>>MATLAB code for duobinary encoder and decoder

clc;
clear all;
close all;

x = [1 0 0 1 1 0 1 1 0 1 0 1];
bp = .00001; %bit period
br = 1/bp;   %bit rate
disp(' Binary Information at Transmitter :');
disp(x);

%plotting the binary signal as digital signal

x_bit=[]; 
for n=1:1:length(x)
    if x(n)==1
       b_se=ones(1,100);
    else 
        b_se=-1*ones(1,100);
    end
     x_bit=[x_bit b_se];
end

t1= bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,x_bit,'lineWidth',2.5);
grid on;
axis([ 0 bp*length(x) -1.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('time(sec)');
title('Transmitting information as digital signal');


%>>>>Encoding
c = Duobinary_Encoder(x);
c = awgn(c,-10);
disp(' Duobinary Encoder output');
disp(c);

%plotting the encoded signal
c_bit=[]; 
for n=1:1:length(x)
    if c(n)== 2
       c_se= 2*ones(1,100);
    elseif c(n) == -2
        c_se= -2*ones(1,100);
    else 
        c_se = zeros(1,100);
    end
     c_bit=[c_bit c_se];
end

t2 = bp/100:bp/100:100*length(c)*(bp/100);
subplot(3,1,2)
plot(t2,c_bit,'lineWidth',2.5);
grid on;
axis([ 0 bp*length(c) -2.5 2.5]);
ylabel('Amplitude(volt)');
xlabel('time(sec)');
title('Encoded Signal');

%>>>>>Decoding

x_out = Duobinary_Decoder(c);
disp(' Duobinary Decoder output');
disp(x_out);
x_out_bit=[]; 
for n=1:1:length(x_out)
    if x_out(n)==1
       se=ones(1,100);
    else 
        se=-1*ones(1,100);
    end
     x_out_bit=[x_out_bit se];
end
subplot(3,1,3);
plot(t1,x_out_bit,'lineWidth',2.5);
grid on;
axis([ 0 bp*length(x) -1.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('time(sec)');
title('Transmitted signal');

%error

e = xor(x_out,x) ;
disp('Error in the precoded Duobinary decoder');
disp(e);


%tries highpass with high frequency signals
clear;
% 1. Design a FIR filter
% 2. Cut-off all frequencies of the S1_1380 Signal
% 3. Doesn't cut off frequencies of S2_1380 Signal
% 4. Apply your filter to S3_1380 Signal
% 5. Plot frequencies of filtered signal
% 6. Repeat for 11025Hz

%Get functions from fourier transform object
ft_func = ft_functions;

%highpass for 11025
hp = 1200;

%steepness
stp = 0.7;

%First signal
x11025 = load("S1_11025.mat");
x_2 = x11025.x_1;

subplot(6,1,1);
[f,P1] = ft_func.fastf(x_2,x11025.fs);
plot(f,P1);
title('fft S1 11025hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


high1 = highpass(x_2,hp,x11025.fs,'ImpulseResponse','fir','Steepness',stp);

subplot(6,1,2);

[f,P1] = ft_func.fastf(high1,x11025.fs);
plot(f,P1);
title('fft S1 11025hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%second signal
y11025 = load("S2_11025.mat");
y_2 = y11025.x_2;

subplot(6,1,3);
[f,P1] = ft_func.fastf(y_2,y11025.fs);
plot(f,P1);
title('fft S2 11025hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(6,1,4);

high2 = highpass(y_2,hp,y11025.fs,'ImpulseResponse','fir','Steepness',stp);
[f,P1] = ft_func.fastf(high2,y11025.fs);
plot(f,P1);
title('fft S2 11025hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%apply to third signal
z11025 = load("S3_11025.mat");
z_2 = z11025.x_3;

subplot(6,1,5);
[f,P1] = ft_func.fastf(z_2,z11025.fs);
plot(f,P1);
title('fft S3 11025hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


subplot(6,1,6);

high3 = highpass(z_2,hp,z11025.fs,'ImpulseResponse','fir','Steepness',stp);
[f,P1] = ft_func.fastf(high3,z11025.fs);
plot(f,P1);
title('fft S3 11025hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

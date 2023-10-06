%tries lowpass with low frequency signals
clear;
% 1. Design a FIR filter
% 2. Cut-off all frequencies of the S1_1380 Signal
% 3. Doesn't cut off frequencies of S2_1380 Signal
% 4. Apply your filter to S3_1380 Signal
% 5. Plot frequencies of filtered signal
% 6. Repeat for 11025Hz


%Get functions from fourier transform object
ft_func = ft_functions;

%lowpass for 1380
lp = 470;

%steepness
stp = 0.8;

%First signal
x1380 = load("S1_1380.mat");
x_1 = x1380.x_1;

subplot(6,1,1);
[f,P1] = ft_func.fastf(x_1,x1380.fs);
plot(f,P1);
title('fft S1 1380hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


low1 = lowpass(x_1,lp,x1380.fs,'ImpulseResponse','fir','Steepness',stp);

subplot(6,1,2);

[f,P1] = ft_func.fastf(low1,x1380.fs);
plot(f,P1);
title('fft S1 1380hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%second signal
y1380 = load("S2_1380.mat");
y_1 = y1380.x_2;

subplot(6,1,3);
[f,P1] = ft_func.fastf(y_1,y1380.fs);
plot(f,P1);
title('fft S2 1380hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(6,1,4);

low2 = lowpass(y_1,lp,y1380.fs,'ImpulseResponse','fir','Steepness',stp);
[f,P1] = ft_func.fastf(low2,y1380.fs);
plot(f,P1);
title('fft S2 1380hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%apply to third signal
z1380 = load("S3_1380.mat");
z_1 = z1380.x_3;

subplot(6,1,5);
[f,P1] = ft_func.fastf(z_1,z1380.fs);
plot(f,P1);
title('fft S3 1380hz before filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


subplot(6,1,6);

low3 = lowpass(z_1,lp,z1380.fs,'ImpulseResponse','fir','Steepness',stp);
[f,P1] = ft_func.fastf(low3,z1380.fs);
plot(f,P1);
title('fft S3 1380hz after filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

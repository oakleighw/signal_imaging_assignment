clear;

%FFT of signals
%Note i included the FFT calculation in the ft_functions file for easier
%reuse.

%First signal
x1380 = load("S1_1380.mat");
x11025 = load("S1_11025.mat");
x_1 = x1380.x_1;
x_2 = x11025.x_1;
%soundsc(x_1,1380);

%second signal
y1380 = load("S2_1380.mat");
y11025 = load("S2_11025.mat");
y_1 = y1380.x_2;
y_2 = y11025.x_2;

%third signal
z1380 = load("S3_1380.mat");
z11025 = load("S3_11025.mat");
z_1 = z1380.x_3;
z_2 = z11025.x_3;


%Get functions from fourier transform object
ft_func = ft_functions;

%first signal first hz
[f,P1] = ft_func.fastf(x_1,x1380.fs);
subplot(6,1,1);
plot(f,P1);
title('fft S1 1380hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%second signal first hz
[f2,P2] = ft_func.fastf(y_1,y1380.fs);
subplot(6,1,2);
plot(f2,P2);
title('fft S2 1380hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


%third signal first hz
[f,P1] = ft_func.fastf(z_1,z1380.fs);
subplot(6,1,3);
plot(f,P1);
title('fft S3 1380hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%first signal second hz
subplot(6,1,4);
[f,P1] = ft_func.fastf(x_2,x11025.fs);
plot(f,P1);
title('fft S1 11025hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


%second signal second hz
subplot(6,1,5);
[f,P1] = ft_func.fastf(y_2,y11025.fs);
plot(f,P1);
title('fft S2 11025hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


%third signal second hz
subplot(6,1,6);
[f,P1] = ft_func.fastf(z_2,z11025.fs);
plot(f,P1);
title('fft S3 11025hz');
xlabel('Frequency (Hz)');
ylabel('Magnitude');


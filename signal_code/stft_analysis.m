clc;clear;close all;

%stft at different window sizes

M = 4096; % window length
g = hann(M,"periodic"); % window
L = floor(0.75*M); % window Overlap
Ndft = M; % FFT Length


%First signal
x1380 = load("S1_1380.mat");
x11025 = load("S1_11025.mat");
x_1 = x1380.x_1;
x_2 = x11025.x_1;
%soundsc(x_1,1380);
figure(1);
s = strcat('-Window Size=',int2str(M)); %window size string

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

figure(1)

%first signal first hz
[st,ft,tt] = stft(x_1,x1380.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
subplot(6,1,1);
plot(ft/x1380.fs,abs(st).^2);
title(strcat('stft S1 1380hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%second signal first hz
[st,ft,tt] = stft(y_1,y1380.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
subplot(6,1,2);
plot(ft/y1380.fs,abs(st).^2);
title(strcat('stft S2 1380hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%third signal first hz
[st,ft,tt] = stft(z_1,z1380.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
subplot(6,1,3);
plot(ft/z1380.fs,abs(st).^2);
title(strcat('stft S3 1380hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%first signal second hz
subplot(6,1,4);
[st,ft,tt] = stft(x_2,x11025.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
plot(ft/x11025.fs,abs(st).^2);
title(strcat('stft S1 11025hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');


%second signal second hz
subplot(6,1,5);
[st,ft,tt] = stft(y_2,y11025.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
plot(ft/y11025.fs,abs(st).^2);
title(strcat('stft S2 11025hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');


%third signal second hz
subplot(6,1,6);
[st,ft,tt] = stft(z_2,z11025.fs, Window=g, OverlapLength=L, FFTLength=Ndft, FrequencyRange="onesided");
plot(ft/z11025.fs,abs(st).^2);
title(strcat('stft S3 11025hz',s));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
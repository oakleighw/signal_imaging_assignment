clc;clear;close all;

%This file plots signals and checks correlation

%First signal
x1380 = load("S1_1380.mat");
x11025 = load("S1_11025.mat");
x_1 = x1380.x_1;
x_2 = x11025.x_1;
%soundsc(x_1,1380);

%set analysis to L seconds of signal (0-19)
L = 2;

%first signal first hz
Fs = x1380.fs;
dt = 1/Fs;
t = 0:dt:L;

figure(1);
subplot(6,1,1);
plot(t, x_1(1:length(t)));
title('S1 1380hz');
xlabel('t');
ylabel('amplitude')

%first signal second hz
Fs = x11025.fs;
dt = 1/Fs;
t = 0:dt:L;

subplot(6,1,2);
plot(t, x_2(1:length(t)));
title('S1 11025hz');
xlabel('t');
ylabel('amplitude')

%second signal
y1380 = load("S2_1380.mat");
y11025 = load("S2_11025.mat");
y_1 = y1380.x_2;
y_2 = y11025.x_2;

%second signal first hz
Fs = y1380.fs;
dt = 1/Fs;
t = 0:dt:L;

subplot(6,1,3);
plot(t, y_1(1:length(t)));
title('S2 1380hz');
xlabel('t');
ylabel('amplitude')

%second signal second hz
Fs = y11025.fs;
dt = 1/Fs;
t = 0:dt:L;

subplot(6,1,4);
plot(t, y_2(1:length(t)));
title('S2 11025hz');
xlabel('t');
ylabel('amplitude')

%third signal
z1380 = load("S3_1380.mat");
z11025 = load("S3_11025.mat");
z_1 = z1380.x_3;
z_2 = z11025.x_3;

%third signal first hz
Fs = z1380.fs;
dt = 1/Fs;
t = 0:dt:L;

subplot(6,1,5);
plot(t, z_1(1:length(t)));
title('S3 1380hz');
xlabel('t');
ylabel('amplitude')

%third signal second hz
Fs = z11025.fs;
dt = 1/Fs;
t = 0:dt:L;

subplot(6,1,6);
plot(t, z_2(1:length(t)));
title('S3 11025hz');
xlabel('t');
ylabel('amplitude')

%check correlation of first 2 added signals and third (lower hertz)
pd = zeros([1 8]); %padding

y = [y_1 pd];
xy =  x_1 + y;

figure(2);

[c,lags] = xcorr(xy,z_1);
stem(lags,c)
title('1380hz autocorrelation');
xlabel('lag');
ylabel('autocorrelation');

display(isequal(xy,z_1)); %displays 1(true) therefore signal 1+2 = 3.

%check correlation of first 2 added signals and third (higher hertz)
pd = zeros([1 8]); %padding

y = [y_2 pd];
xy =  x_2 + y;

figure(3);

[c,lags] = xcorr(xy,z_2);
stem(lags,c)
title('11025hz autocorrelation');
xlabel('lag');
ylabel('autocorrelation');

display(isequal(xy,z_2)); %displays 1(true) therefore signal 1+2 = 3.


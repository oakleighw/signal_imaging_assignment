clc;clear;close all;

%First signal
x1380 = load("S1_1380.mat");
x11025 = load("S1_11025.mat");
x_1 = x1380.x_1;
x_2 = x11025.x_1;

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

%soundsc(x_1,1380);

%first signal first hz


% We create a CWT filter bank that can be applied to the signal. 
fb = cwtfilterbank(SignalLength=numel(x_1),SamplingFrequency=x1380.fs,Wavelet = "morse");
% the plot to confirm frequency range
figure(1)
freqz(fb);


figure(2)
cwt(x_1,FilterBank=fb);

title("S1 1380 Magnitude Scalogram")


%first signal second hz

% We create a CWT filter bank that can be applied to the signal. 
fb = cwtfilterbank(SignalLength=numel(x_2),SamplingFrequency=x11025.fs,Wavelet = "morse");
%Need to determine frequency limits as per documentation.

% the plot to confirm frequency range
figure(3)
freqz(fb);

figure(4)
cwt(x_2,FilterBank=fb);
title("S1 11025 Magnitude Scalogram");


%second signal first hz
fb = cwtfilterbank(SignalLength=numel(y_1),SamplingFrequency=y1380.fs,Wavelet = "morse");

figure(5)
cwt(y_1,FilterBank=fb);
title("S2 1380 Magnitude Scalogram")

%second signal second hz
fb = cwtfilterbank(SignalLength=numel(y_2),SamplingFrequency=y11025.fs,Wavelet = "morse");

figure(6)
cwt(y_2,FilterBank=fb);
title("S2 11025 Magnitude Scalogram");

%third signal first hz
%second signal first hz
fb = cwtfilterbank(SignalLength=numel(z_1),SamplingFrequency=z1380.fs,Wavelet = "morse");

figure(7)
cwt(z_1,FilterBank=fb);
title("S3 1380 Magnitude Scalogram")

%third signal second hz
fb = cwtfilterbank(SignalLength=numel(z_2),SamplingFrequency=z11025.fs,Wavelet = "morse");

figure(8)
cwt(z_2,FilterBank=fb);
title("S3 11025 Magnitude Scalogram")
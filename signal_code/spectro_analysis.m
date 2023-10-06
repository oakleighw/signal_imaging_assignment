clear;

M = 4096; % window length
g = hann(M,"periodic"); % window
L = 0.75*M; % window Overlap
Ndft = M; % FFT Length


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

%first signal first hz
[sx,fx,tx] = spectrogram(x_1, g, L,Ndft, x1380.fs, "onesided");
subplot(3,2,1);
waterfall(tx,fx/x1380.fs, abs(sx).^2);
title('Spectrogram S1 1380hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')

%first signal second hz
subplot(3,2,2);
[sx,fx,tx] = spectrogram(x_2, g, L,Ndft, x11025.fs, "onesided");
waterfall(tx,fx/x11025.fs, abs(sx).^2);
title('Spectrogram S1 11025hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')

%second signal first hz
[sx,fx,tx] = spectrogram(y_1, g, L,Ndft, y1380.fs, "onesided");
subplot(3,2,3);
waterfall(tx,fx/y1380.fs, abs(sx).^2);
title('Spectrogram S2 1380hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')

%second signal second hz
subplot(3,2,4);
[sx,fx,tx] = spectrogram(y_2, g, L,Ndft, y11025.fs, "onesided");
waterfall(tx,fx/y11025.fs, abs(sx).^2);
title('Spectrogram S2 11025hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')



%third signal first hz
[sx,fx,tx] = spectrogram(z_1, g, L,Ndft, z1380.fs, "onesided");
subplot(3,2,5);
waterfall(tx,fx/z1380.fs, abs(sx).^2);
title('Spectrogram S3 1380hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')

%third signal second hz
subplot(3,2,6);
[sx,fx,tx] = spectrogram(z_2, g, L,Ndft, z11025.fs, "onesided");
waterfall(tx,fx/z11025.fs, abs(sx).^2);
title('Spectrogram S3 11025hz');
xlabel('time[sec]')
ylabel('frequency[kHz]')
zlabel('Magnitude[dB]')
clear; close all;

img = imread("DATASET/ara2013_plant001_rgb.png");

grey = rgb2gray(img);

[r, c] = size(grey);

subplot(2,4,1);
imshow(grey);
title('Greyscale Image');

%adjust contrast
J = imadjust(grey,[0.2 0.5],[]);

subplot(2,4,2);
imshow(J);
title('Contrast-adjusted Image');

T = adaptthresh(J,0.99);
%binarize
BW = imbinarize(J,T);
subplot(2,4,3);

imshow(BW);
title('Binarised Image');

FT_img = fft2(double(BW));

subplot(2,4,4);
imshow(FT_img);
title('FFT of Image');
  
% Assign Cut-off Frequency  
D0 = 10; % one can change this value accordingly

%https://www.geeksforgeeks.org/matlab-ideal-highpass-filter-in-image-processing/
% Designing filter
u = 0:(r-1);
idx = find(u>r/2);
u(idx) = u(idx)-r;
v = 0:(c-1);
idy = find(v>c/2);
v(idy) = v(idy)-c;
  
% MATLAB library function meshgrid(v, u) returns 2D grid
%  which contains the coordinates of vectors v and u. 
% Matrix V with each row is a copy of v, and matrix U 
% with each column is a copy of u
[V, U] = meshgrid(v, u);
  
% Calculating Euclidean Distance
D = sqrt(U.^2+V.^2);
  
% Comparing with the cut-off frequency and 
% determining the filtering mask
H = double(D > D0);
  
% Convolution between the Fourier Transformed image and the mask
G = H.*FT_img;

subplot(2,4,5);
imshow(G);
title('FFT of Image after highpass');
% Getting the resultant image by Inverse Fourier Transform
% of the convoluted image using MATLAB library function
% ifft2 (2D inverse fast fourier transform)  

output_image = real(ifft2(double(G)));


subplot(2,4,6);
imshow(output_image);
title('Inverse image FFT after highpass');

subplot(2,4,7);
output_image = imbinarize(output_image); % remove fft noise no threshold
imshow(output_image);
title('Re-Binarized image');

%imbinarize at different threshold to fully remove fft noise
subplot(2,4,8);
output_image_clean = bwareaopen(BW, 70); % remove fft noise
imshow(output_image_clean);

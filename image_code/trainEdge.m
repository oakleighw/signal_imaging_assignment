clc;clear;close all;

img = imread("DATASET/ara2013_plant002_rgb.png");

%greyscale
grey = rgb2gray(img);

subplot(2,3,1);
imshow(grey);
title('Greyscale');

subplot(2,3,2);
J = imadjust(grey,[0.2 0.5],[]);

imshow(J)
title('Contrast adjustment');
T = adaptthresh(J,0.99);


%binarize
BW = imbinarize(J,T);

%remove small objects
BW = bwareaopen(BW, 70);

%fill any holes
BW = imfill(BW, 'holes');


subplot(2,3,3);

BW =imclearborder(BW,4);%removes items connected to edge
imshow(BW);
title('Binarised');

s =strel('disk',1);

%erode
ime =imerode(BW,s);

subplot(2,3,4);
imshow(ime);
title('Eroded');

%minus erosion from original image to get edge
subplot(2,3,5);
imshow(BW-ime);
title('Binarized minus eroded image');


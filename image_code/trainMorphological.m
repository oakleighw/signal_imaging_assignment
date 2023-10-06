clear; close all;

img = imread("DATASET/ara2013_plant005_rgb.png");

grey = rgb2gray(img);

subplot(3,6,1);
imshow(grey);
title('Greyscale');

[counts,x] = imhist(grey,16);

subplot(3,6,2);

stem(x,counts);
title('Greyscale Histogram');
xlabel('Pixel Intensity');
ylabel('Count');

%adjust contrast
sep = imadjust(grey,[0.4 0.6],[]);
[counts,x] = imhist(sep,16);
subplot(3,6,3);
imshow(sep);
title('Contrast adjusted leaves');

subplot(3,6,4);
stem(x,counts)
title('Histogram after leaf contrast');
xlabel('Pixel Intensity');
ylabel('Count');

J = imadjust(grey,[0.2 0.5],[]);

[counts,x] = imhist(J,16);
subplot(3,6,5);
imshow(J);
title('Contrast adjusted full');

J = imgaussfilt(J,0.9);

subplot(3,6,6);
imshow(J);
title('Gaussian filter');

subplot(3,6,7);
stem(x,counts)
title('Histogram after full contrast');
xlabel('Pixel Intensity');
ylabel('Count');


%binarize
T = adaptthresh(sep,0.99);%adapt threshold

BW = imbinarize(sep,T);
subplot(3,6,8);

imshow(BW);
title('Binarized leaves');

%clear noise
BWClean = bwareaopen(BW, 70);

subplot(3,6,9);
imshow(BWClean)
title('Leaves w/o small objects');


se = strel('disk', 2);

cl = imclose(BWClean,se);
subplot(3,6,10);
imshow(cl);
title('imClosed leaves');

subplot(3,6,11);
bw = imfill(cl, 'holes');
imshow(bw);
title('Leaves w/ filled holes');

%have this for leaves, full segment for stalks

subplot(3,6,12);
edg = edge(bw,'canny');
imshow(edg);
title('Canny leaf edges');

%no seperation
%binarize
T = adaptthresh(J,0.99);%adapt threshold

BW = imbinarize(J,T);


%clear noise
BWClean = bwareaopen(BW, 70);


subplot(3,6,13);
bwMerge = imfill(BWClean, 'holes');
bwMerge = imclearborder(bwMerge,4); %clear connections to border
title('Canny leaf edges');

edgMerge = edge(bwMerge,'canny');
imshow(edgMerge);
title('Full image canny');

subplot(3,6,14);
%minus images to get connections
Z=((1-bw) - (1-bwMerge));  %Preferred
imshow(Z);
title('Binarized full image minus leaf sections');

subplot(3,6,15);
%minus edges to get connecting components
cons = Z-edgMerge -edg;
imshow(cons);
title('Connected leaf components');

%erode
se = strel('disk',2);
conEr = imerode(cons,se);

subplot(3,6,16);
imshow(conEr);
title('Eroding connections');

%detect edge
conEdg = edge(conEr,'canny');


subplot(3,6,17);
imshow(conEdg);
title('Edge of connections');




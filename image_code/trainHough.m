%Attempt to split leaves using hough circles

clear; close all;

img = imread("DATASET/ara2013_plant002_rgb.png");

grey = rgb2gray(img);


%[r, c] = size(I_resized);

subplot(2,6,1);
imshow(grey);
title('Greyscale');

%adjust contrast
J = imadjust(grey,[0.2 0.8],[]);

subplot(2,6,2);
imshow(J);
title('Contrast adjust');

%binarize
T = adaptthresh(J,0.99);%adapt threshold

BW = imbinarize(J,T);
subplot(2,6,3);

imshow(BW);
title('Binarized');

%clear noise
BWClean = bwareaopen(BW, 70);

subplot(2,6,4);
imshow(BWClean)
title('Small items removed');

se = strel('disk', 1);
BW2 = imopen(BWClean,se);

subplot(2,6,5);
imshow(BW2);
title('After opening');

edges = edge(BW2,'canny');

subplot(2,6,6);
%output_image = imbinarize(output_image); % remove fft noise
imshow(edges);
title('After Canny with found circles');

[c1, r1] = imfindcircles(edges,[10,30], 'Sensitivity', 0.94);

viscircles(c1, r1,'EdgeColor','w');

%add circles to binary image to separate them

subplot(2,6,7);
imshow(BW);
title('Circles applied to binary image');
viscircles(c1, r1,'EdgeColor','black');

%create new image

%https://stackoverflow.com/questions/26906928/separate-two-overlapping-circles-in-an-image-using-matlab
num_circles = numel(r1); %// Get number of circles
struct_reg = []; %// Save the shape analysis per circle / line here

%// For creating our circle in the temporary image
[X,Y] = meshgrid(1:size(BW,2), 1:size(BW,1));

%// Storing all of our circles in this image
circles_img = false(size(BW));

for idx = 1 : num_circles %// For each circle we have...        
    %// Place our circle inside a temporary image    
    r = r1(idx);
    cx = c1(idx,1); cy = c1(idx,2);
    tmp = (X - cx).^2 + (Y - cy).^2 <= r^2;        

    % // Save in master circle image
    circles_img(tmp) = true;
end
subplot(2,6,8);
%now got leaves as circles image
imshow(circles_img);
title('Circles alone');

circEdge = edge(circles_img,'canny');
subplot(2,6,9);
imshow(circEdge);
title('Circles alone edges');

subplot(2,6,10);
fullEdge = edge(BWClean,'canny');
imshow(fullEdge);
title('Canny edge of original image');

subplot(2,6,11);
Z=1-((1-circEdge) & (1-fullEdge));  %Preferred
imshow(Z);
title('Union of circle edges and OG edges');

subplot(2,6,12);
%Z = imfill(Z,'holes');
se = strel('disk',1);
new = imopen(Z,se);
se = strel('disk',25);
new = imclose(new,se);
imshow(new);
title('Attempt at isolating leaf connections');


%Now try with opening filled diagram and plotting diff

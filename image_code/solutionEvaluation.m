%read images and compare
clear; close all;

p = pwd;
d = pwd + "\DATASET";

file_list = dir(d);

bounds = {};
ims = {};

pre = []; %precision vals
re = []; %recall vals
f = []; %F1 vals

%filter to just images and add to list of images to be processed
for i = 1:numel(file_list)
    
    file = file_list(i);
    [filepath,name,ext] = fileparts(file.name);
    abs_path = fullfile(file.folder, file.name);

    %if file name contains boundary, add to boundary list
    if regexp(file.name, "[a-zA-Z]+2013_[A-Za-z0-9]+_boundaries\.png")
        I = imread(abs_path); % load image
        bounds{end+1} = I; % append to image array
    end
    
    %if file name rgb, add to image list
    if regexp(file.name, "[a-zA-Z]+2013_[A-Za-z0-9]+_rgb\.png")
        I = imread(abs_path); % load image
        ims{end+1} = I; % append to image array
    end
    
end

for l=1:length(ims)
    im = cell2mat(ims(l));
    grey = rgb2gray(im);

 
 
    %adjust contrast

    J = imadjust(grey,[0.2 0.5],[]);
% %%%%Erosion Method %%%%%    
%     T = adaptthresh(J,0.99);
% 
%     %binarize
%     BW = imbinarize(J,T);
%     BW = bwareaopen(BW, 70);
%     BW = imfill(BW, 'holes');
%     %BW =imclearborder(BW,4);
% 
%     s =strel('disk',1);
% 
%     ime =imerode(BW,s);
% 
%     sol = BW-ime;
    
%%%%% Canny/Morphological Method
%     %J = imgaussfilt(J);
%     
%     %no seperation
%     %binarize
%     T = adaptthresh(J,0.99);%adapt threshold
% 
%     BW = imbinarize(J,T);
%     
%     %remove connections to border
%     %BW = imclearborder(BW,1);
%     %clear noise
%     BWClean = bwareaopen(BW, 70);
% 
% 
%     bwMerge = imfill(BWClean, 'holes');
%     
%     %bwMerge = imclearborder(bwMerge,4);
%     
%     edgMerge = edge(bwMerge,'canny');

%%%% FFT high-pass method
    
    [r, c] = size(J);
    
    T = adaptthresh(J,0.99);
    %binarize
    BW = imbinarize(J,T);

    FT_img = fft2(double(BW));

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

    % Getting the resultant image by Inverse Fourier Transform
    % of the convoluted image using MATLAB library function
    % ifft2 (2D inverse fast fourier transform)  

    output_image = real(ifft2(double(G)));

    output_image = imbinarize(output_image); % remove fft noise no threshold
    
    sol = output_image; %solution
    
    b = cell2mat(bounds(l));
    GT = b == 1;
    
    %imshowpair(edgMerge, bin_img);
    [rows, columns, numberOfColorChannels] = size(GT); % get rows and cols sizes

    TP=0;FP=0;TN=0;FN=0;
    % compare pixel values for "1" in segmented and GT images and add to
    % relevant metric
    for i=1:rows
        for j=1:columns
            if (sol(i,j) == 1 && GT(i,j) ==1)
                TP = TP+1;
            elseif(sol(i,j) == 1 && GT(i,j) ~= 1)
                FP=FP+1;
            elseif(sol(i,j) ~= 1 && GT(i,j) ~= 1)
                TN = TN +1;
            else
                FN = FN+1;
            end
        end
    end
    
    % calculate precision & recall
    Precision = TP/(TP+FP);
    Recall = TP/(TP+FN);
    Fone = 2 * ((Precision * Recall) / (Precision + Recall));
    
    pre = [pre Precision];
    re = [re Recall];
    f = [f Fone];
    
end


%create table showing metrics
Precision = [pre];
Precision(isnan(Precision))=0; %change NaNs to 0 if present
Recall = [re];
Recall(isnan(Recall))=0;
F1 = [f];
F1(isnan(F1))=0;

metrics = table(Precision,Recall,F1);
disp(metrics);

Mp = mean(Precision);
Sp = std(Precision);
Mr = mean(Recall);
Sr = std(Recall);
Mf = mean(F1);
Sf = std(F1);

sumMetrics = table(Mp,Sp,Mr,Sr,Mf,Sf);
disp(sumMetrics);



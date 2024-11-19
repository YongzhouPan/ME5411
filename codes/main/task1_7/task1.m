% Task 1
close all;
clear all;
clc;

script_path = fileparts(mfilename('fullpath'));

utils_path = fullfile(script_path, '../../utils');
functions_path = fullfile(script_path, '../../functions');
data_path = fullfile(script_path, '../../data');

addpath(genpath(utils_path));
addpath(genpath(functions_path));
addpath(data_path);

% Path for saving images
save_path = fullfile(script_path, '../../imgs/1.originalContractEnhance');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

%% Display original image
% Read and plot
img_path = 'charact2.bmp';
img_raw = imread(img_path);
img_size = size(img_raw);

% Check image type
img_type = imgType(img_raw);
disp("Input Image: " + which(img_path) + newline + "Type: " + img_type);

% Convert to grayscale (unit 8)
if strcmp(img_type, 'color')
    img_grayscale = rgb2gray(img_raw);
    disp('Image converted to grayscale.');
elseif strcmp(img_type, 'grayscale')
    img_grayscale = img_raw;
    disp('Image is already grayscale.');
else
    error('Unknown image type. Exiting program.');
end

% Plot
figure;
imshow(img_raw);
title('Original Image', 'FontSize', 16);
saveas(gcf, fullfile(save_path, 'original_image.png'));

%% Prepare for multi-plot
figure('Name', 'Image Processing Results', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 800]);

% Use tiledlayout for tight layout
t = tiledlayout(3, 3, 'TileSpacing', 'compact', 'Padding', 'compact');

% Display original image
nexttile;
imshow(img_raw);
title('Original Image', 'FontSize', 16);

% Display grayscale image
nexttile;
imshow(img_grayscale);
title('Grayscale Image', 'FontSize', 16);

%% Contrast Stretching
% Normal contrast stretching case
nexttile;
point1 = [5, 0];
point2 = [250, 255];
img_enhanced = contractStretching(img_grayscale, point1, point2);
imshow(img_enhanced);
title('Contrast Stretching', 'FontSize', 16);

% Piecewise linear contrast stretching
nexttile;
point1 = [100, 10];
point2 = [250, 255];
img_enhanced_piecewise = contractStretching(img_grayscale, point1, point2);
imshow(img_enhanced_piecewise);
title('Contrast Stretching Piecewise', 'FontSize', 16);

%% Brightness Thresholding
nexttile;
point1 = [136, 0];
point2 = [136, 255];
img_threshold = contractStretching(img_grayscale, point1, point2);
imshow(img_threshold);
title('Brightness Thresholded', 'FontSize', 16);

%% Gray Level Slicing
nexttile;
A = 120;
B = 250;
intensity = 0;
img_sliced = grayLevelSlicing(img_grayscale, A, B, 'preserve', intensity);
imshow(img_sliced);
title('Gray Level Sliced', 'FontSize', 16);

%% Dynamic Range Compression (Not suitable for this task)
nexttile;
img_compressed = dynamicRangeCompression(img_grayscale);
imshow(img_compressed);
title('Dynamic Range Compressed', 'FontSize', 16);

%% Pseudocolor Image Processing
nexttile;
threshold = 136;
img_pseudocolor = pseudocolorProcessing(img_grayscale, threshold);
imshow(img_pseudocolor);
title('Pseudocolor Image', 'FontSize', 16);

%% Histogram Equalization
nexttile;
q0 = 100;
qk = 200;
img_equalized = histogramEqualization(img_grayscale, q0, qk);
imshow(img_equalized);
title('Histogram Equalized', 'FontSize', 16);

saveas(gcf, fullfile(save_path, 'combined_contract_enhance_comparison.png'));

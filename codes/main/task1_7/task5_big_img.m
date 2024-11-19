% Task 5: Combined Thresholding Comparison
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
save_path = fullfile(script_path, '../../imgs/5.imageBinary');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

% img_path = 'charact2.bmp';
img_path = 'charact2_sub.bmp';
img_raw = imread(img_path);

% Check image type and convert to grayscale (unit 8)
img_type = imgType(img_raw);
if strcmp(img_type, 'color')
    img_grayscale = rgb2gray(img_raw);
elseif strcmp(img_type, 'grayscale')
    img_grayscale = img_raw;
else
    error('Unknown image type. Exiting program.');
end

%% Morphological Operations (opening)
se = strel('disk', 5);
img_morph = opening(img_grayscale, se);


%% Binary Images
% Global Threshold
threshold = 128;
img_binary_global = globalThreshold(img_grayscale, threshold);
img_binary_global_morph = globalThreshold(img_morph, threshold);

% Global Threshold with Histogram Equalization
q0 = 100;
qk = 200;
threshold = 165;
% threshold = 185; % Good for full image
img_equalized = histogramEqualization(img_grayscale, q0, qk);
img_binary_equalized = globalThreshold(img_equalized, threshold);
img_equalized_morph = histogramEqualization(img_morph, q0, qk);
img_binary_equalized_morph = globalThreshold(img_equalized_morph, threshold);

% Otsu Threshold
img_binary_otsu = otsuThreshold(img_grayscale);
img_binary_otsu_morph = otsuThreshold(img_morph);

% Double Threshold
threshold_low = 128;
threshold_high = 170;
img_binary_double = doubleThreshold(img_grayscale, threshold_low, threshold_high);
img_binary_double_morph = doubleThreshold(img_morph, threshold_low, threshold_high);

% Local Threshold
filter_size = 30;
img_binary_local = localThreshold(img_grayscale, filter_size);
img_binary_local_morph = localThreshold(img_morph, filter_size);

%% Plot All Results in One Figure
figure('Name', 'Task 5: Thresholding Methods Comparison', 'NumberTitle', 'off', 'Position', [100, 100, 1600, 1200]);
t = tiledlayout(6, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Original and Morphological
nexttile; imshow(img_grayscale); title('Original Image', 'FontSize', 16);
nexttile; imshow(img_morph); title('After Morphological Operation', 'FontSize', 16);

% Global Threshold
nexttile; imshow(img_binary_global); title('Global Threshold (Original)', 'FontSize', 16);
nexttile; imshow(img_binary_global_morph); title('Global Threshold (Morph)', 'FontSize', 16);

% Global Threshold with Histogram Equalization
nexttile; imshow(img_binary_equalized); title('Global Hist. Equal. (Original)', 'FontSize', 16);
nexttile; imshow(img_binary_equalized_morph); title('Global Hist. Equal. (Morph)', 'FontSize', 16);

% Otsu Threshold
nexttile; imshow(img_binary_otsu); title('Otsu Threshold (Original)', 'FontSize', 16);
nexttile; imshow(img_binary_otsu_morph); title('Otsu Threshold (Morph)', 'FontSize', 16);

% Double Threshold
nexttile; imshow(img_binary_double); title('Double Threshold (Original)', 'FontSize', 16);
nexttile; imshow(img_binary_double_morph); title('Double Threshold (Morph)', 'FontSize', 16);

% Local Threshold
nexttile; imshow(img_binary_local); title('Local Threshold (Original)', 'FontSize', 16);
nexttile; imshow(img_binary_local_morph); title('Local Threshold (Morph)', 'FontSize', 16);

saveas(gcf, fullfile(save_path, 'combined_thresholding_comparison.png'));
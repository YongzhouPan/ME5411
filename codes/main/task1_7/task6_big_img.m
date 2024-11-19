% Task 6
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
save_path = fullfile(script_path, '../../imgs/6.edgeDetection');
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

%% Binary Images
se = strel('disk', 5);
img_morph = opening(img_grayscale, se);

% Global Threshold with Histogram Equalization
q0 = 100;
qk = 200;
threshold = 165;
% threshold = 185; % Good for full image
img_equalized_morph = histogramEqualization(img_morph, q0, qk);
img_binary_equalized_morph = globalThreshold(img_equalized_morph, threshold);

% Otsu Threshold
img_binary_otsu_morph = otsuThreshold(img_morph);

% Local Threshold
filter_size = 30;
img_binary_local_morph = localThreshold(img_morph, filter_size);

%% Edge Detection for Original and Binary Images
binaries = {img_grayscale, img_binary_equalized_morph, img_binary_otsu_morph, img_binary_local_morph};
titles = {'Original Image', 'Global Hist. Equal.', 'Otsu Threshold', 'Local Threshold'};

figure('Name', 'Edge Detection Comparison', 'NumberTitle', 'off', 'Position', [100, 100, 2000, 800]);
t = tiledlayout(4, 4, 'TileSpacing', 'compact', 'Padding', 'compact');

for i = 1:length(binaries)
    img_binary = binaries{i};
    title_binary = titles{i};

    % Sobel Operator
    img_edge_sobel = sobelOperator(img_binary);

    % Canny Operator
    low_thresh = 0.1;
    high_thresh = 0.3;
    img_edge_canny = cannyOperator(img_binary, low_thresh, high_thresh);

    % Laplacian Operator
    img_edge_laplacian = laplacianOperator(img_binary);

    % Plot each set of results
    nexttile; imshow(img_binary, []); title(['Binary Image (' title_binary ')'], 'FontSize', 16);
    nexttile; imshow(img_edge_sobel, []); title('Sobel Operator', 'FontSize', 16);
    nexttile; imshow(img_edge_canny, []); title('Canny Operator', 'FontSize', 16);
    nexttile; imshow(img_edge_laplacian, []); title('Laplacian Operator', 'FontSize', 12);
end

saveas(gcf, fullfile(save_path, 'edge_detection_comparison.png'));

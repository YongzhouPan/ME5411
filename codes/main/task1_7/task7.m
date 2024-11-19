% Task 7
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
save_path = fullfile(script_path, '../../imgs/7.imageSegmentation');
results_path = fullfile(save_path, 'results');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

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

% Initialize step index
step_index = 1;

%% Morphological Operations (opening)
se = strel('disk', 5);
img_morph_opened = opening(img_grayscale, se);

figure; imshow(img_morph_opened);
title(sprintf('Step %d: Morphological Opening', step_index));
saveas(gcf, fullfile(save_path, sprintf('Step%d_MorphologicalOpening.png', step_index)));
step_index = step_index + 1;

%% Histogram Equalization
q0 = 100;
qk = 200;
threshold = 165;
img_equalized_morph = histogramEqualization(img_morph_opened, q0, qk);

figure; imshow(img_equalized_morph, []);
title(sprintf('Step %d: Histogram Equalization', step_index));
saveas(gcf, fullfile(save_path, sprintf('Step%d_HistogramEqualization.png', step_index)));
step_index = step_index + 1;

%% Morphological Operations (closing) (Performance Not Desired)
% se = strel('disk', 2);
% img_morph_closed = closing(img_equalized_morph, se);
% 
% figure; imshow(img_morph_closed, []);
% title(sprintf('Step %d: Morphological Closing'), step_index));
% saveas(gcf, fullfile(save_path, sprintf('Step%d_MorphologicalClosing.png', step_index)));
% step_index = step_index + 1;

%% Global Threshold
img_binary = globalThreshold(img_equalized_morph, threshold);

figure; imshow(img_binary);
title(sprintf('Step %d: Binary Image (Global Hist. Equalization)', step_index));
saveas(gcf, fullfile(save_path, sprintf('Step%d_BinaryImage.png', step_index)));
step_index = step_index + 1;

%% Average Filter
img_filtered_5x5 = averageFilter(img_binary, 5);

figure; imshow(img_filtered_5x5);
title(sprintf('Step %d: Average Filter (5x5)', step_index));
saveas(gcf, fullfile(save_path, sprintf('Step%d_AverageFilter.png', step_index)));
step_index = step_index + 1;

%% Segmentation
imgs_segmented = imageSegmentation(img_filtered_5x5, 120, 50, results_path);

%% Plot Combined Large Images
figure('Name', 'Task 7 - Large Images', 'NumberTitle', 'off', 'Position', [100, 100, 1600, 600]);
t_large = tiledlayout(2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

large_images = {img_morph_opened, img_equalized_morph, img_binary, img_filtered_5x5};
large_titles = {... 
    'Step 1: Morphological Opening', ...
    'Step 2: Histogram Equalization', ...
    'Step 3: Binary Image', ...
    'Step 4: Average Filter'};

for i = 1:length(large_images)
    nexttile(t_large);
    imshow(large_images{i}, []);
    title(large_titles{i}, 'FontSize', 16);
end

saveas(gcf, fullfile(save_path, 'Task7_LargeImages.png'));

%% Plot Combined Segmented Small Images
figure('Name', 'Task 7 - Segmented Images', 'NumberTitle', 'off', 'Position', [100, 100, 1600, 900]);
rows_small = ceil(length(imgs_segmented) / 5);
cols_small = 5;
t_small = tiledlayout(rows_small, cols_small, 'TileSpacing', 'compact', 'Padding', 'compact'); 

segmentation_titles = {};
for i = 1:length(imgs_segmented)
    segmentation_titles{end+1} = sprintf('Segmented Character %d', i);
end

for i = 1:length(imgs_segmented)
    nexttile(t_small);
    imshow(imgs_segmented{i}, []);
    title(segmentation_titles{i}, 'FontSize', 16);
end

saveas(gcf, fullfile(save_path, 'Task7_SegmentedImages.png'));
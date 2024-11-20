% Task 2
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
save_path = fullfile(script_path, '../../imgs/2.averageFilter');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

img_path = 'charact2.bmp';
img_raw = imread(img_path);
img_size = size(img_raw);

%% 3 * 3 average filter
img_filtered_3x3 = averageFilter(img_raw, 3);

%% 5 * 5 average filter
img_filtered_5x5 = averageFilter(img_raw, 5);

%% 7 * 7 average filter
img_filtered_7x7 = averageFilter(img_raw, 7);

%% Plot Results
figure('Name', 'Image Processing Results', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 800]);
t = tiledlayout(4, 1, 'TileSpacing', 'compact', 'Padding', 'compact');

nexttile; imshow(img_raw); title('Original Image', 'FontSize', 16);
nexttile; imshow(img_filtered_3x3); title('Filtered Image (3x3)', 'FontSize', 16);
nexttile; imshow(img_filtered_5x5); title('Filtered Image (5x5)', 'FontSize', 16);
nexttile; imshow(img_filtered_7x7); title('Filtered Image (7x7)', 'FontSize', 16);

saveas(gcf, fullfile(save_path, 'combined_average_filter_comparison.png'));
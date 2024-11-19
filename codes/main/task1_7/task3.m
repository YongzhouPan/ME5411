% Task 3
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
save_path = fullfile(script_path, '../../imgs/3.highpassFilter');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

img_path = 'charact2.bmp';
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

%% High-pass Filter
% Apply different high-pass filters
img_highpass_005 = highpassFilter(img_grayscale, 0.08, 'Ideal');        % Ideal Filter, Cutoff 0.08
img_highpass_05 = highpassFilter(img_grayscale, 0.5, 'Ideal');          % Ideal Filter, Cutoff 0.5
img_highpass_gaussian = highpassFilter(img_grayscale, 0.08, 'Gaussian'); % Gaussian Filter, Cutoff 0.08
img_highpass_butterworth = highpassFilter(img_grayscale, 0.08, 'Butterworth', 2); %     , Order 2, Cutoff 0.08

%% Plot Results
figure('Name', 'High-pass Filtering Results', 'NumberTitle', 'off', 'Position', [100, 100, 1400, 900]);
t = tiledlayout(3, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
nexttile; imshow(img_grayscale, []); title('Original Image', 'FontSize', 16);
nexttile; imshow(img_highpass_005, []); title('Ideal High-pass Filter (Cutoff 0.08)', 'FontSize', 16);
nexttile; imshow(img_highpass_05, []); title('Ideal High-pass Filter (Cutoff 0.5)', 'FontSize', 16);
nexttile; imshow(img_highpass_gaussian, []); title('Gaussian High-pass Filter (Cutoff 0.08)', 'FontSize', 16);
nexttile; imshow(img_highpass_butterworth, []); title('Butterworth High-pass Filter (Cutoff 0.08, Order 2)', 'FontSize', 16);

saveas(gcf, fullfile(save_path, 'combined_highpass_filter_comparison.png'));
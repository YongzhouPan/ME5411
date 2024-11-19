% Task 4
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

img_path = 'charact2.bmp';
img_raw = imread(img_path);

% Path for saving the cropped image
save_path = fullfile(script_path, '../../data');
output_filename = 'charact2_sub.bmp';
output_path = fullfile(save_path, output_filename);

% Cropping region
[top_left_x, bottom_right_x, top_left_y, bottom_right_y] = deal(40, 960, 200, 340);
region_crop = [top_left_x, top_left_y, abs(bottom_right_x - top_left_x), abs(bottom_right_y - top_left_y)];

% Crop the image
image_crop = imcrop(img_raw, region_crop);

% Display the sub-image
figure;
imshow(image_crop);
title('Sub-image with the middle line – HD44780A00', 'FontSize', 16);

if ~exist(save_path, 'dir')
    mkdir(save_path);
end
imwrite(image_crop, output_path);

% Save to 'imgs'
save_path = fullfile(script_path, '../../imgs/4.imageCrop');
if ~exist(save_path, 'dir')
    mkdir(save_path);
end

output_filename = 'charact2_sub.bmp';
output_path = fullfile(save_path, output_filename);

imwrite(image_crop, output_path);
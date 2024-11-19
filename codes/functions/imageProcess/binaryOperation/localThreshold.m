function img_binary = localThreshold(img_grayscale, filter_size)
    % LOCALTHRESHOLD Perform local thresholding on a grayscale image.
    %
    % img_binary = localThreshold(img_grayscale, filter_size) applies local
    % thresholding using the mean of a neighborhood defined by a square
    % filter of size filter_size.
    %
    % Inputs:
    %   - img_grayscale: Input grayscale image (2D matrix).
    %   - filter_size: Size of the square averaging filter (e.g., 15 for 15x15).
    %
    % Outputs:
    %   - img_binary: Binary image after applying local thresholding.
    
    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('localThreshold: Input must be a grayscale image.');
    end

    % Create averaging filter
    h = fspecial('average', [filter_size filter_size]);

    % Compute the local mean
    local_mean = imfilter(img_grayscale, h);

    % Apply local thresholding
    img_binary = img_grayscale > local_mean;
end
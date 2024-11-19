function img_binary = doubleThreshold(img_grayscale, threshold_low, threshold_high)
    % DOUBLETHRESHOLD Perform double thresholding on a grayscale image.
    %
    % img_binary = doubleThreshold(img_grayscale, threshold_low, threshold_high)
    % applies double thresholding to the input grayscale image.
    %
    % Inputs:
    %   - img_grayscale: Input grayscale image (2D matrix).
    %   - threshold_low: Lower threshold value.
    %   - threshold_high: Upper threshold value.
    %
    % Outputs:
    %   - img_binary: Binary image after applying double thresholding.

    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('doubleThreshold: Input must be a grayscale image.');
    end

    % Check if thresholds are valid
    if threshold_low >= threshold_high
        error('doubleThreshold: Lower threshold must be less than upper threshold.');
    end

    % Apply double thresholding
    img_binary = (img_grayscale > threshold_low) & (img_grayscale < threshold_high);
end
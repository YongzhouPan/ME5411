function image_binary = otsuThresholdCustom(img_grayscale)
    % OTSUTHRESHOLDCUSTOM Perform Otsu's thresholding on a grayscale image.
    %
    % image_binary = otsuThresholdCustom(image_grayscale) applies Otsu's
    % method to compute the optimal threshold for binarizing the grayscale
    % image.
    %
    % Inputs:
    %   - image_grayscale: Input grayscale image (2D matrix).
    %
    % Outputs:
    %   - image_binary: Binary image after applying Otsu's method.

    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('otsuThresholdCustom: Input must be a grayscale image.');
    end

    % Compute histogram
    num_bins = 256; % Assuming 8-bit image
    histogram = imhist(img_grayscale, num_bins); % Compute histogram
    total_pixels = numel(img_grayscale); % Total number of pixels

    % Initialize variables
    sum_total = sum((0:(num_bins-1))' .* histogram); % Total weighted sum of intensities
    sum_background = 0; % Cumulative sum of intensities for the background class
    weight_background = 0; % Weight (probability) of the background class
    max_variance = 0; % Maximum between-class variance
    optimal_threshold = 0; % Optimal threshold to be determined

    % Iterate through all possible thresholds
    for t = 1:num_bins
        % Update the weights for the background class
        weight_background = weight_background + histogram(t); % Weight of background class
        weight_foreground = total_pixels - weight_background; % Weight of foreground class

        % Avoid division by zero for empty classes
        if weight_background == 0 || weight_foreground == 0
            continue;
        end

        % Update the cumulative sum for the background class
        sum_background = sum_background + (t-1) * histogram(t);

        % Compute the mean of the two classes
        mean_background = sum_background / weight_background; % Mean of background class
        mean_foreground = (sum_total - sum_background) / weight_foreground; % Mean of foreground class

        % Compute the between-class variance
        between_class_variance = weight_background * weight_foreground * (mean_background - mean_foreground)^2;

        % Update the maximum variance and the optimal threshold
        if between_class_variance > max_variance
            max_variance = between_class_variance;
            optimal_threshold = t - 1; % MATLAB indices start from 1
        end
    end

    % Convert the grayscale image to binary using the optimal threshold
    image_binary = img_grayscale > optimal_threshold;

    % Display the optimal threshold (optional for debugging)
    disp(['Optimal Threshold: ', num2str(optimal_threshold)]);
end

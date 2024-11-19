function img_edge = cannyOperator(img_grayscale, low_thresh, high_thresh)
    % CANNYOPERATOR Perform Canny edge detection on a grayscale image.
    %
    % img_edge = cannyOperator(img_grayscale, low_thresh, high_thresh) applies
    % the Canny edge detection algorithm with specified thresholds.
    %
    % Inputs:
    %   - img_grayscale: Grayscale input image (2D matrix).
    %   - low_thresh: Lower threshold for hysteresis (0-1, normalized).
    %   - high_thresh: Upper threshold for hysteresis (0-1, normalized).
    %
    % Output:
    %   - img_edge: Binary edge-detected image using Canny operator.
    
    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end

    % Use MATLAB's built-in edge function with Canny method
    img_edge = edge(img_grayscale, 'Canny', [low_thresh, high_thresh]);
end
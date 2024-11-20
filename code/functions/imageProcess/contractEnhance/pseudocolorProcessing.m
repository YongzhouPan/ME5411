function img_pseudocolor = pseudocolorProcessing(img_grayscale, threshold)
    % PSEUDOCOLORPROCESSING Apply binary pseudocolor processing to a grayscale image.
    %
    % img_pseudocolor = PSEUDOCOLORPROCESSING(img_gray, threshold) maps the grayscale intensity values
    % to a pseudocolor range where:
    %   - Values <= threshold are mapped to blue [0, 0, 255].
    %   - Values > threshold are mapped to yellow [255, 255, 0].
    %
    % Inputs:
    %   - img_gray: A grayscale image (2D matrix) with pixel values between 0 and 255.
    %   - threshold: The threshold value separating blue and yellow regions.
    %
    % Output:
    %   - img_pseudocolor: The pseudocolor image (MxNx3 RGB).
    %
    % Example:
    %   img_gray = imread('charact2.bmp');
    %   img_pseudocolor = pseudocolorProcessing(img_gray, 128);
    %   imshow(img_pseudocolor);

    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('pseudocolorProcessing: Input must be a grayscale image.');
    end

    % Initialize RGB image
    img_pseudocolor = zeros(size(img_grayscale, 1), size(img_grayscale, 2), 3, 'uint8');

    % Create and apply masks for the two conditions
    mask_blue = img_grayscale <= threshold;
    mask_yellow = img_grayscale > threshold;

    img_pseudocolor(:, :, 1) = 0;
    img_pseudocolor(:, :, 2) = 0;
    img_pseudocolor(:, :, 3) = uint8(mask_blue) * 255;
    
    img_pseudocolor(:, :, 1) = img_pseudocolor(:, :, 1) + uint8(mask_yellow) * 255;
    img_pseudocolor(:, :, 2) = img_pseudocolor(:, :, 2) + uint8(mask_yellow) * 255;
    img_pseudocolor(:, :, 3) = img_pseudocolor(:, :, 3) + uint8(mask_yellow) * 0;
end
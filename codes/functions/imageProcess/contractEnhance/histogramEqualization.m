function img_equalized = histogramEqualization(img_raw, q0, qk)
    % HISTOGRAMEQUALIZATION Perform histogram equalization with adjustable output range.
    %
    % img_equalized = HISTOGRAMEQUALIZATION(img_gray, q0, qk) enhances the contrast
    % of a grayscale image by redistributing its pixel intensity values.
    %
    % Inputs:
    %   - img_gray: A grayscale image (MxN matrix) with pixel values between 0 and 255.
    %   - q0: Minimum value of the output range.
    %   - qk: Maximum value of the output range.
    %
    % Output:
    %   - img_equalized: The histogram-equalized image, with pixel values in [q0, qk].
    %
    % Example:
    %   img_gray = imread('example_8bit.bmp');
    %   img_equalized = histogramEqualization(img_gray, 50, 200);
    %   imshow(img_equalized);

    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_raw);
    if ~strcmp(img_type, 'grayscale')
        error('histogramEqualization: Input must be a grayscale image.');
    end

    % Compute histogram
    hist_counts = imhist(img_raw);

    % Normalize histogram to obtain PDF, numel(img_gray) means rows*cols in this case 
    pdf = hist_counts / numel(img_raw);

    % Compute CDF
    cdf = cumsum(pdf);

    % Map the original pixel values to equalized values in the range [q0, qk]
    equalized_values = uint8(q0 + (qk - q0) * cdf);

    % Replace pixel values in the original image
    % Add 1 for matlab 1-based indexing to search within equalized_values
    img_equalized = equalized_values(double(img_raw) + 1);
end
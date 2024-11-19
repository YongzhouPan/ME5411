function img_enhanced = contractStretching(img_raw, point1, point2)
    % CONTRACTSTRETCHING Perform piecewise linear contrast stretching based on two points.
    %
    % img_enhanced = CONTRACTSTRETCHING(img_raw, point1, point2)
    % enhances the contrast of a grayscale image using two breakpoints.
    %
    % Inputs:
    %   - img_raw: A grayscale image (2D matrix) with pixel values between 0 and 255.
    %   - point1: [r1, s1], where r1 is the input intensity and s1 is the output intensity.
    %   - point2: [r2, s2], where r2 is the input intensity and s2 is the output intensity.
    %
    % Output:
    %   - img_enhanced: The contrast-enhanced image.
    %
    % Example:
    %   img_gray = imread('charact2.bmp');
    %   img_enhanced = contractStretching(img_gray, [50, 100], [200, 200]);
    %   imshow(img_enhanced);
    
    % Ensure utils path is added to access imgType
    addpath(genpath('../../../utils'));

    % Check if the image is grayscale
    img_type = imgType(img_raw);
    if ~strcmp(img_type, 'grayscale')
        error('contractStretching: Input must be a grayscale image.');
    end

    % Extract r1, s1, r2, s2 from input points
    r1 = point1(1);
    s1 = point1(2);
    r2 = point2(1);
    s2 = point2(2);
    
    % Check input validity
    if r1 > r2
        error('r1 must be less than or equal to r2.');
    end
    if s1 > s2
        error('s1 must be less than or equal to s2.');
    end

    % Initialize the output image
    img_enhanced = zeros(size(img_raw), 'double');

    % Map range [0, r1] -> [0, s1]
    mask_low = img_raw <= r1;
    slope_low = s1 / r1; % Linear mapping slope for [0, r1]
    img_enhanced(mask_low) = slope_low * double(img_raw(mask_low));

    % Map range [r1, r2] -> [s1, s2]
    mask_mid = img_raw > r1 & img_raw <= r2;
    slope_mid = (s2 - s1) / (r2 - r1); % Linear mapping slope for [r1, r2]
    img_enhanced(mask_mid) = s1 + slope_mid * (double(img_raw(mask_mid)) - r1);

    % Map range [r2, 255] -> [s2, 255]
    mask_high = img_raw > r2;
    slope_high = (255 - s2) / (255 - r2); % Linear mapping slope for [r2, 255]
    img_enhanced(mask_high) = s2 + slope_high * (double(img_raw(mask_high)) - r2);

    % Convert the output image to uint8
    img_enhanced = uint8(img_enhanced);
end
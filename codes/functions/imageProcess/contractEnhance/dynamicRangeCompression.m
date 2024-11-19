function img_compressed = dynamicRangeCompression(img_raw)
    % DYNAMICRANGECOMPRESSION Apply dynamic range compression to a grayscale image.
    %
    % img_compressed = DYNAMICRANGECOMPRESSION(img_raw) compresses the dynamic range
    % of the input grayscale image using the logarithmic function:
    %   T(r) = c * log(1 + |r|)
    %
    % Inputs:
    %   - img_raw: A grayscale image (MxN matrix), can be uint8, uint16, or float.
    %
    % Output:
    %   - img_compressed: The image after dynamic range compression (uint8 format).
    %
    % Example:
    %   img_gray = imread('example_8bit.bmp');
    %   img_compressed = dynamicRangeCompression(img_gray);
    %   imshow(img_compressed);

    % Determine the maximum possible pixel value based on the input type
    if isa(img_raw, 'uint8')
        max_pixel_value = 255; % 8-bit
    elseif isa(img_raw, 'uint16')
        max_pixel_value = 65535; % 16-bit
    elseif isa(img_raw, 'double') || isa(img_raw, 'single')
        max_pixel_value = max(img_raw(:)); % Use actual max for float images
    else
        error('Unsupported image type. Use uint8, uint16, or floating-point images.');
    end

    % Calculate the scaling constant c
    c = 255 / log(1 + max_pixel_value);

    % Normalize the input image to [0, 1]
    img_normalized = double(img_raw) / double(max_pixel_value);

    % Apply logarithmic transformation
    img_transformed = c * log(1 + img_normalized);

    % Rescale the transformed image to [0, 255]
    img_compressed = uint8(255 * img_transformed / max(img_transformed(:)));
end
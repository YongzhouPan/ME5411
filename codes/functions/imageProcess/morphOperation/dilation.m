function img_dilated = dilation(img_grayscale, se)
    % DILATION Perform grayscale dilation on an image.
    % 
    % img_dilated = dilation(img_grayscale, se) applies morphological 
    % dilation to the input grayscale image using the given structuring element (se).
    %
    % Inputs:
    %   - img_grayscale: Grayscale input image.
    %   - se: Structuring element created with strel().
    %
    % Output:
    %   - img_dilated: Dilated grayscale image.

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    if isBinImg(img_grayscale)
        error('Input must be a grayscale image, not a binary image.');
    end
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end

    % Convert structuring element to binary matrix
    se = se.Neighborhood;

    [rows, cols] = size(img_grayscale);
    [se_rows, se_cols] = size(se);

    % Pad the input image
    padded_img = padarray(img_grayscale, [floor(se_rows / 2), floor(se_cols / 2)], -Inf);

    % Initialize output image
    img_dilated = zeros(rows, cols);

    % Perform dilation
    for i = 1:rows
        for j = 1:cols
            % Extract neighborhood and compute maximum
            neighborhood = padded_img(i:i+se_rows-1, j:j+se_cols-1);
            img_dilated(i, j) = max(neighborhood(se == 1));
        end
    end

    img_dilated = uint8(img_dilated);
end
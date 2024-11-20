function img_eroded = erosion(img_grayscale, se)
    % EROSION Perform grayscale erosion on an image.
    % 
    % img_eroded = erosion(img_grayscale, se) applies morphological erosion
    % to the input grayscale image using the given structuring element (se).
    %
    % Inputs:
    %   - img_grayscale: Grayscale input image.
    %   - se: Structuring element created with strel().
    %
    % Output:
    %   - img_eroded: Eroded grayscale image.
    
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
    padded_img = padarray(img_grayscale, [floor(se_rows / 2), floor(se_cols / 2)], Inf);

    % Initialize output image
    img_eroded = zeros(rows, cols);

    % Perform erosion
    for i = 1:rows
        for j = 1:cols
            % Extract neighborhood and compute minimum
            neighborhood = padded_img(i:i+se_rows-1, j:j+se_cols-1);
            img_eroded(i, j) = min(neighborhood(se == 1));
        end
    end

    img_eroded = uint8(img_eroded);
end
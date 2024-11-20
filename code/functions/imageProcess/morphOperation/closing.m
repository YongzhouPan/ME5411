function img_closed = closing(img_grayscale, se)
    % CLOSING Perform morphological closing on a binary image.
    %
    % img_closed = closing(img_grayscale, se) applies morphological closing
    % (dilation followed by erosion) to the input image using the given 
    % structuring element (se).
    %
    % Inputs:
    %   - img_grayscale: Grayscale input image.
    %   - se: Structuring element created with strel().
    %
    % Output:
    %   - img_closed: Image after closing operation.

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    if isBinImg(img_grayscale)
        error('Input must be a grayscale image, not a binary image.');
    end
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end

    % Perform dilation followed by erosion
    img_dilated = dilation(img_grayscale, se);
    img_closed = erosion(img_dilated, se);
end
function img_opened = opening(img_grayscale, se)
    % OPENING Perform morphological opening on an image.
    %
    % img_opened = opening(img_grayscale, se) applies morphological opening
    % (erosion followed by dilation) to the input image using the given 
    % structuring element (se).
    %
    % Inputs:
    %   - img_grayscale: Grayscale input image.
    %   - se: Structuring element created with strel().
    %
    % Output:
    %   - img_opened: Image after opening operation.

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    if isBinImg(img_grayscale)
        error('Input must be a grayscale image, not a binary image.');
    end
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end
    
    % Perform erosion followed by dilation
    img_eroded = erosion(img_grayscale, se);
    img_opened = dilation(img_eroded, se);
end
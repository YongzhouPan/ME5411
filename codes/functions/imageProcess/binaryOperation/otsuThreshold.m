function image_binary = otsuThreshold(img_grayscale)
    % OTSUTHRESHOLD Perform Otsu's thresholding on a grayscale image.
    %
    % image_binary = otsuThreshold(image_grayscale) binarizes the input image
    % using Otsu's method to find the optimal threshold.
    %
    % Inputs:
    %   - image_grayscale: Grayscale input image.
    %
    % Output:
    %   - image_binary: Binary image.
    
    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('otsuThreshold: Input must be a grayscale image.');
    end
    
    % Normalized threshold
    level = graythresh(img_grayscale);
    
    % Compute Otsu's threshold
    otsu_threshold = level * 255; % Convert to pixel value range

    % Binarize the image
    image_binary = img_grayscale > otsu_threshold;
end
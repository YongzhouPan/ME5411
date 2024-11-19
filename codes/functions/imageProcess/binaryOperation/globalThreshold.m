function image_binary = globalThreshold(img_grayscale, threshold)
    % GLOBALTHRESHOLD Perform global thresholding on a grayscale image.
    %
    % image_binary = globalThreshold(image_grayscale, threshold) binarizes 
    % the input image based on a fixed threshold value.
    %
    % Inputs:
    %   - image_grayscale: Grayscale input image.
    %   - threshold: Threshold value (0-255).
    %
    % Output:
    %   - image_binary: Binary image.
    
    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('globalThreshold: Input must be a grayscale image.');
    end

    % Binarize the image
    image_binary = img_grayscale > threshold;
end

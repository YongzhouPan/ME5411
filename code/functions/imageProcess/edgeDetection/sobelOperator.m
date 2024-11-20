function img_edge = sobelOperator(img_grayscale)
    % SOBELOPERATOR Perform Sobel edge detection on a grayscale image.
    %
    % img_edge = sobelOperator(img_grayscale) computes the gradient magnitude 
    % using the Sobel operator without using built-in filtering functions.
    %
    % Input:
    %   - img_grayscale: Grayscale input image (2D matrix).
    %
    % Output:
    %   - img_edge: Edge-detected image using Sobel operator.

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end
    
    % Convert to double
    img = im2double(img_grayscale);

    % Initialize gradient matrices
    [rows, cols] = size(img);
    grad_x = zeros(rows, cols);
    grad_y = zeros(rows, cols);

    % Sobel edge detection (manually calculated)
    for i = 2:rows-1
        for j = 2:cols-1
            % Sobel X kernel
            grad_x(i, j) = abs(img(i-1, j+1) - img(i-1, j-1) + 2*img(i, j+1) - 2*img(i, j-1) + img(i+1, j+1) - img(i+1, j-1));
            % Sobel Y kernel
            grad_y(i, j) = abs(img(i-1, j-1) - img(i+1, j-1) + 2*img(i-1, j) - 2*img(i+1, j) + img(i-1, j+1) - img(i+1, j+1));
        end
    end

    % Combine gradients
    img_edge = grad_x + grad_y;

    % Normalize the output to [0, 255]
    img_edge = uint8(255 * (img_edge / max(img_edge(:))));
end
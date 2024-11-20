function img_edge = laplacianOperator(img_grayscale)
    % LAPLACIANOPERATOR Perform Laplacian edge detection on a grayscale image.
    %
    % img_edge = laplacianOperator(img_grayscale) computes the edge map using 
    % the Laplacian operator with a predefined kernel.
    %
    % Input:
    %   - img_grayscale: Grayscale input image (2D matrix).
    %
    % Output:
    %   - img_edge: Edge-detected image using Laplacian operator.

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end

    % Define Laplacian kernel
    laplacian_kernel = [0 -1 0; -1 4 -1; 0 -1 0];

    % Apply Laplacian filter using imfilter
    img_edge = imfilter(double(img_grayscale), laplacian_kernel, 'replicate');

    % Normalize the output to [0, 255] and convert to uint8
    img_edge = uint8(255 * (img_edge / max(img_edge(:))));
end
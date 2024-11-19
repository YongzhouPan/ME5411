function img_filtered = averageFilter(img_raw, filter_size)
    % AVERAGEFILTER Apply an averaging filter to an image (supports grayscale or RGB).
    %
    % img_filtered = averageFilter(img, filter_size) applies a square averaging
    % filter of size filter_size * filter_size to the input image.
    %
    % Inputs:
    %   - img: The input grayscale or color image (RGB).
    %   - filter_size: Size of the square filter (e.g., 5 for a 5x5 filter).
    %
    % Output:
    %   - img_filtered: The filtered image after applying the averaging filter.
    %
    % Example:
    %   img_filtered = averageFilter(img, 5);
    %   imshow(img_filtered);

    % Ensure the filter size is odd
    if mod(filter_size, 2) == 0
        error('Filter size must be an odd integer.');
    end

    % Create the averaging filter
    filter_mask = ones(filter_size, filter_size) / (filter_size^2);

    % Check if the image is grayscale or RGB
    if size(img_raw, 3) == 1
        % Grayscale image
        img_filtered = zeros(size(img_raw), 'like', img_raw);
        img_filtered(:, :) = imfilter(img_raw, filter_mask);
    elseif size(img_raw, 3) == 3
        % RGB image
        img_filtered = zeros(size(img_raw), 'like', img_raw);
        for channel = 1:size(img_raw, 3)
            img_filtered(:, :, channel) = imfilter(img_raw(:, :, channel), filter_mask);
        end
    end
end
function img_filtered = highpassFilter(img_grayscale, cutoff_ratio, mode, n)
    % HIGHPASSFILTER Apply a high-pass filter to an image in the frequency domain.
    %
    % img_filtered = highpassFilter(img, cutoff_ratio, mode, n) applies a high-pass filter
    % in the frequency domain with a specified cutoff ratio and filter type.
    %
    % Inputs:
    %   - img: The input grayscale image (2D matrix).
    %   - cutoff_ratio: Cutoff frequency ratio (0 to 1), where 1 corresponds to
    %     the highest frequency and values closer to 0 filter fewer high frequencies.
    %   - mode: Filter type, can be 'Ideal', 'Gaussian', or 'Butterworth'.
    %   - n: Filter order (only used for Butterworth filters, optional for others).
    %
    % Output:
    %   - img_filtered: The high-pass filtered image in the spatial domain.
    %
    % Example:
    %   img_filtered = highpassFilter(img, 0.1, 'Ideal');
    %   img_filtered = highpassFilter(img, 0.1, 'Gaussian');
    %   img_filtered = highpassFilter(img, 0.1, 'Butterworth', 2);

    % Ensure the input is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_grayscale);
    if ~strcmp(img_type, 'grayscale')
        error('Input must be a grayscale image.');
    end

    img_grayscale = double(img_grayscale);
    [rows, cols] = size(img_grayscale);
    
    % Compute the 2D Fourier Transform of the image and shift zero frequency to the center
    F = fft2(img_grayscale);
    F_shifted = fftshift(F);

    % Create a high-pass filter based on the mode
    [X, Y] = meshgrid(-cols/2:(cols/2-1), -rows/2:(rows/2-1));
    D = sqrt(X.^2 + Y.^2); % Distance from the center
    D0 = cutoff_ratio * max(rows, cols) / 2; % Cutoff frequency

    % Initialize the high-pass filter
    switch lower(mode)
        case 'ideal'
            % Ideal High-Pass Filter
            H = double(D > D0);

        case 'gaussian'
            % Gaussian High-Pass Filter
            H = 1 - exp(-(D.^2) / (2 * D0^2));

        case 'butterworth'
            % Butterworth High-Pass Filter
            if nargin < 4
                error('For Butterworth filter, order n must be specified.');
            end
            H = 1 ./ (1 + (D0 ./ D).^(2 * n));

        otherwise
            error('Unsupported filter mode. Use "Ideal", "Gaussian", or "Butterworth".');
    end

    % Apply the high-pass filter in the frequency domain
    F_filtered = F_shifted .* H;

    % Inverse Fourier Transform to get the result in the spatial domain
    F_ishifted = ifftshift(F_filtered);
    img_filtered = real(ifft2(F_ishifted)); % Convert to spatial domain
end
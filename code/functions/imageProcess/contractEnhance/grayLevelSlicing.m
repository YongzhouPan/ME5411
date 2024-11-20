function img_sliced = grayLevelSlicing(img_raw, A, B, mode, intensity)
    % GRAYLEVELSLICING Apply gray level slicing on the input image with custom intensity.
    %
    % img_sliced = GRAYLEVELSLICING(img_raw, A, B, mode, intensity)
    % enhances the intensity range [A, B] in the image. Two modes are supported:
    %   1. Preserve: Keep intensity outside [A, B].
    %   2. Diminish: Set intensity outside [A, B] to 0.
    %
    % Inputs:
    %   - img_raw: A grayscale image (2D matrix) with pixel values between 0 and 255.
    %   - A: The lower boundary of the slicing range.
    %   - B: The upper boundary of the slicing range.
    %   - mode: 'preserve' or 'diminish', to specify the treatment of values outside [A, B].
    %   - intensity: The intensity value for the [A, B] range (default: 255).
    %
    % Output:
    %   - img_sliced: The image after gray level slicing.
    %
    % Example:
    %   img_gray = imread('charact2.bmp');
    %   img_sliced = grayLevelSlicing(img_gray, 100, 200, 'preserve', 128);
    %   imshow(img_sliced);

    % Default intensity if not provided
    if nargin < 5
        intensity = 255;
    end

    % Check if the image is grayscale
    addpath(genpath('../../../utils'));
    img_type = imgType(img_raw);
    if ~strcmp(img_type, 'grayscale')
        error('grayLevelSlicing: Input must be a grayscale image.');
    end

    % Initialize output image
    img_sliced = zeros(size(img_raw), 'uint8');

    % Apply gray level slicing
    if strcmp(mode, 'preserve')
        % Enhance [A, B], preserve other levels
        img_sliced(img_raw >= A & img_raw <= B) = intensity; % Highlight range [A, B]
        img_sliced(img_raw < A | img_raw > B) = img_raw(img_raw < A | img_raw > B); % Keep other levels
    elseif strcmp(mode, 'diminish')
        % Enhance [A, B], diminish other levels
        img_sliced(img_raw >= A & img_raw <= B) = intensity; % Highlight range [A, B]
        img_sliced(img_raw < A | img_raw > B) = 0; % Set other levels to black
    else
        error('grayLevelSlicing: Unsupported mode. Use ''preserve'' or ''diminish''.');
    end
end
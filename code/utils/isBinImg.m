function is_binary = isBinImg(img)
    % ISBINIMG Check if the input image is a binary image
    %
    % is_binary = isBinImg(img) checks whether the input image is a binary
    % image, defined as either logical or uint8 type with values restricted
    % to 0 and 1.
    %
    % Inputs:
    %   - img: The input image
    %
    % Outputs:
    %   - is_binary: Returns true if the image is binary, false otherwise

    % Check if the image is of logical type
    if islogical(img)
        is_binary = true;
        return;
    end

    % Check if the image is uint8 and contains only 0 and 1
    if isa(img, 'uint8') && all(img(:) == 0 | img(:) == 1)
        is_binary = true;
    else
        is_binary = false;
    end
end
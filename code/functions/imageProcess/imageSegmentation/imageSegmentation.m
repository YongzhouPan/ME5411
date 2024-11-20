function imgs_segmented = imageSegmentation(img_bin, width_threshold, min_area, output_dir)
    % IMAGESEGMENTATION Segments characters from a binary image and saves them.
    %
    % imgs_segmented = imageSegmentation(img_bin, width_threshold, min_area, output_dir)
    % segments connected components (characters) from a binary image. If a
    % component's width exceeds the threshold, it is split into two parts.
    %
    % Inputs:
    %   - img_bin: Binary input image (logical or uint8).
    %   - width_threshold: Threshold for splitting wide components.
    %   - min_area: Minimum area to consider a valid region.
    %   - output_dir: Directory to save segmented images.
    %
    % Output:
    %   - imgs_segmented: Cell array containing segmented character images.
    %
    % Example:
    %   imgs_segmented = imageSegmentation(img_bin, 120, 50, './output/');

    % Ensure the input image is binary
    addpath(genpath('../../../utils'));
    if ~isBinImg(img_bin)
        error('Input image must be binary (logical or uint8).');
    end

    % Convert to logical if necessary
    if isa(img_bin, 'uint8')
        img_bin = img_bin > 0;
    end

    % Ensure output directory exists
    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end

    % Extract connected components and their properties
    cc = bwconncomp(img_bin);
    characterProps = regionprops(cc, 'BoundingBox', 'Area');

    % Initialize a counter for saving images
    cnt = 1;
    imgs_segmented = {}; % Cell array to store segmented characters

    % Loop through each connected component
    for i = 1:length(characterProps)
        % Get bounding box and area of the component
        bb = characterProps(i).BoundingBox;
        area = characterProps(i).Area;

        % Ignore components with area smaller than the minimum area
        if area < min_area
            continue;
        end

        % Crop the character using the bounding box
        character = imcrop(img_bin, bb);

        % Check the width of the component
        if size(character, 2) > width_threshold
            % Split the character into two parts
            mid_idx = ceil(size(character, 2) / 2);
            character1 = character(:, 1:mid_idx);
            character2 = character(:, mid_idx + 1:end);

            % Store and save the segmented characters
            imgs_segmented{end + 1} = character1;
            imwrite(character1, fullfile(output_dir, sprintf('char_%d.png', cnt)));
            cnt = cnt + 1;

            imgs_segmented{end + 1} = character2;
            imwrite(character2, fullfile(output_dir, sprintf('char_%d.png', cnt)));
            cnt = cnt + 1;
        else
            % Store and save the character as it is
            imgs_segmented{end + 1} = character;
            imwrite(character, fullfile(output_dir, sprintf('char_%d.png', cnt)));
            cnt = cnt + 1;
        end
    end
end

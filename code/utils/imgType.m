function img_type = imgType(img_raw)
    [~, ~, channels] = size(img_raw);
    
    if channels == 1
        img_type = 'grayscale';
    elseif channels == 3
        img_type = 'color';
    else
        img_type = 'unknown';
    end
end
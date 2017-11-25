function [CA] = wavelet_compress(image_name)
    original_image = load_img(image_name);
    current_img = original_image;
    [r, c] = size( current_img );
    i = 0;
    
    while c >= 8 && r >= 8
        [CA, CH, CV, CD] = dwt2(current_img, 'haar');
        current_img = CA;
        %TO DO apply limiar to CH, CV, CD
        
        symbols_probabilites = tabulate( round(CH(:)./ 2) );
        dict = huffmandict( symbols_probabilites(:,1), (symbols_probabilites(:, 3)/ 100) );
        i = i + 1;
        [r, c] = size( current_img );
    end
    imshow( uint8(CA ./ 32));
end

function img = load_img(image_name)
    color_img = imread(image_name);
    img = rgb2gray(color_img);
end
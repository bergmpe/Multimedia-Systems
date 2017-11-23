function negative_img = negative(image_path)
    gray_img = load_img(image_path);
    L = max( gray_img(:) );
    negative_img = L - gray_img; 
    imshow( [gray_img, negative_img] );
end

function gray_img = load_img(image_path)
    original_img = imread(image_path);
    gray_img = rgb2gray(original_img);
end
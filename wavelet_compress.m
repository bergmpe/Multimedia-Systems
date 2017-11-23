function [CA, CH, CV, CD] = wavelet_compress(image_name)
original_image = load_img(image_name);
[CA, CH, CV, CD] = dwt2(original_image, 'haar');
imshow(CA);
end

function img = load_img(image_name)
    color_img = imread(image_name);
    img = rgb2gray(color_img);
end
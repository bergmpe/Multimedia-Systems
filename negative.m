color_img = imread('lena.jpg');
gray_img = rgb2gray(color_img);

L = max( gray_img(:) );
negative_img = L - gray_img; 
imshow( [gray_img, negative_img] );
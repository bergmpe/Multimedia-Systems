color_img = imread('lena.jpg');
gray_img = rgb2gray(color_img);

m = 100;
A = gray_img < m;
A = A .* 255;

new_img = A ;
imshow( [gray_img, new_img] );
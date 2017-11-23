color_img = imread('lena.jpg');
gray_img = rgb2gray(color_img);

A = gray_img <= 85;
A = A .* double(gray_img ./ 2);

B = (gray_img > 85 & gray_img < 170);
B = B .* (double(gray_img .* 2) - 127);

C = gray_img >= 170;
C = C .* (double(gray_img ./ 2) + 127);

new_img = A + B + C;
imshow( [gray_img, new_img] );
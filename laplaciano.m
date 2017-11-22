%load image
color_img = imread('lena4.jpg');
gray_img = rgb2gray(color_img);

%average filter
h = fspecial('laplacian', 0.0);
filtered_img = imfilter(gray_img, h);
figure, imshow( [gray_img, filtered_img + gray_img ] );
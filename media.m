%load image
color_img = imread('lena4.jpg');
gray_img = rgb2gray(color_img);

%add noise
noise_img = imnoise(gray_img,'salt & pepper', 0.05);
figure, imshow( [ gray_img, noise_img] );

%average filter
h = fspecial('average', 3);
filteres_img = imfilter(noise_img, h);
figure, imshow( [gray_img, filteres_img] );




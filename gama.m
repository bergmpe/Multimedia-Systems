color_img = imread('lena.jpg');
gray_img = rgb2gray(color_img);

L = max( gray_img(:) );
gama_img = double(gray_img) .^ 1.5;
L_gama = max( gama_img(:));
factor =  double(L) / L_gama;
gama_img = gama_img * factor;

imshow( [gray_img, gama_img] );
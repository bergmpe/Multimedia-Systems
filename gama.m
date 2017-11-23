function gama_img = gama(image_path, c, y)
    gray_img =load_img(image_path);
    L = max( gray_img(:) );
    gama_img = double(gray_img * c) .^ y;
    L_gama = max( gama_img(:));
    factor =  double(L) / L_gama;
    gama_img = gama_img * factor;
    imshow( [gray_img, gama_img] );
end

function gray_img = load_img(image_path)
    original_img = imread(image_path);
    gray_img = rgb2gray(original_img);
end
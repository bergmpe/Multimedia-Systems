function new_img = alargamento_contraste1( image_path, m )
    gray_img = load_img(image_path);
    new_img = (gray_img < m) * 255;
    imshow( [gray_img, new_img] );
end

function gray_img = load_img(image_path)
    original_img = imread(image_path);
    gray_img = rgb2gray(original_img);
end
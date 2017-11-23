function new_img = alargamento_contraste(image_path, x1, x2)
    gray_img = load_img(image_path);

    A = gray_img <= x1;
    A = A .* double( gray_img ./ 2 );

    B = (gray_img > x1 & gray_img < x2);
    a = (x2 - 0.5 * x1)/(x2 - x1);
    B = B .* (double(gray_img .* a) + 0.5 *  x1*(1 - a));

    C = gray_img >= x2;
    C = C .* (double(gray_img ./ 2) + (0.5 * x2));

    new_img = A + B + C;
    imshow( [gray_img, new_img] );
end

function gray_img = load_img(image_path)
    original_img = imread(image_path);
    gray_img = rgb2gray(original_img);
end
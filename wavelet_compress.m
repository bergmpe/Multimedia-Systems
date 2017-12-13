function [CA] = wavelet_compress(image_name, compress)
    CAS = {};
    CHS = {};
    CVS = {};
    CDS = {};
    original_image = load_img(image_name);
    current_img = original_image;
    [r, c] = size( current_img );
    i = 1;
    
    while c >= 8 && r >= 8
        [CA, CH, CV, CD] = dwt2(current_img, 'haar');
        current_img = CA;
        
        CA = round(CA);
        CH = round(CH);
        CV = round(CV);
        CD = round(CD);
        %apply limiar to CH, CV, CD
        CH = limiar(CH, compress);
        CV = limiar(CV, compress);
        CD = limiar(CD, compress);
        
        CAS(:,:, i) = {CA./2};
        CHS(:,:, i) = {CH./2};
        CVS(:,:, i) = {CV./2};
        CDS(:,:, i) = {CD./2};
        
        %symbols_probabilites = tabulate( round(CH(:)./ 2) );
        %dict = huffmandict( symbols_probabilites(:,1), (symbols_probabilites(:, 3)/ 100) );
        i = i + 1;
        [r, c] = size( current_img );
    end
    
    imshow( uint8(CA ./ 32));
end

function img = load_img(image_name)
    color_img = imread(image_name);
    img = rgb2gray(color_img);
end

function Y = limiar(X, compress)
    Y = X;
    pivo = 1;
    total_elem = numel(Y);
    total_zeros = sum( Y(:) == 0 );
    while compress > (total_zeros / total_elem)
        Y = (Y ~= pivo) .* Y;
        Y = (Y ~= -pivo) .* Y;
        pivo = pivo + 1;
        total_zeros = sum( Y(:) == 0 );
    end
end
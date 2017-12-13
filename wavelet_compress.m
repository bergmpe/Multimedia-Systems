function [CA RE] = wavelet_compress(image_name, compress)
    CHS = {};
    CVS = {};
    CDS = {};
    original_image = load_img(image_name);
    CA = original_image;
    [r, c] = size( CA );
    counter = 1;
    
    while c > 32 && r > 32
        [CA, CH, CV, CD] = dwt2(CA, 'haar');
        %current_img = CA./2;
        
        CA = round(CA./2);
        CH = round(CH./2);
        CV = round(CV./2);
        CD = round(CD./2);
        %apply limiar to CH, CV, CD
        CH = limiar(CH, compress);
        CV = limiar(CV, compress);
        CD = limiar(CD, compress);
        
        CHS(:,:, counter) = {CH};
        CVS(:,:, counter) = {CV};
        CDS(:,:, counter) = {CD};
        
        %symbols_probabilites = tabulate( round(CH(:)./ 2) );
        %dict = huffmandict( symbols_probabilites(:,1), (symbols_probabilites(:, 3)/ 100) );
        counter = counter + 1;
        [r, c] = size( CA );
    end
    counter = counter - 1;
    
    
    for i = counter:-1:1
        disp(i)
        CA = idwt2( CA.*2, cell2mat(CHS(:,:, i)).*2, cell2mat(CVS(:,:, i)).*2, cell2mat(CDS(:,:, i)).*2,'haar');
        RE = cell2mat(CDS(:,:, i)).*2;
        disp(RE);
    end
    imshow([original_image, uint8(CA)]);
    %imshow(uint8(CA));
    
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
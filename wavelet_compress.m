function [compress_rate error] = wavelet_compress(image_name, compress, N)
    CHS = {};
    CVS = {};
    CDS = {};
    original_image = load_img(image_name);
    CA = original_image;
    [r, c] = size( CA );
    counter = 1;
    
    while c > 8 && r > 8 && counter <= N
        [CA, CH, CV, CD] = dwt2(CA, 'haar');
        
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
        
        counter = counter + 1;
        [r, c] = size( CA );
    end
    counter = counter - 1;
    %rebuild the image
    for i = counter:-1:1
        CA = idwt2( CA.*2, cell2mat(CHS(:,:, i)).*2, cell2mat(CVS(:,:, i)).*2, cell2mat(CDS(:,:, i)).*2,'haar');
    end
    imshow([original_image, uint8(CA)]);
    
    %symbols_probabilites = tabulate( round(CH(:)./ 2) );
    %dict = huffmandict( symbols_probabilites(:,1), (symbols_probabilites(:, 3)/ 100) );
    SYM = unique(CA);
    PROB = hist(CA(:), SYM)./length(CA(:)) ;
    dict = huffmandict( SYM, PROB );
    comp = huffmanenco(CA(:), dict);
    compress_rate = ( numel(de2bi((comp))) / numel(de2bi(original_image)));
    %compress_rate = numel(de2bi(cell2mat(dict)));
    error = immse(original_image, uint8(CA));
    
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
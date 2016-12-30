function [ result ] = resizeImg( img )
%RESIZEIMG resize image to 20*20.If width less than 20, add blanks on both
%sides.Otherwise use 'imresize' function.
%   result -- result image
%   img --image

    x = size(img,2);
    if x<20
        t = 20-x;
        l = round(t/2);
        r = t-l;
        zl = zeros(20,l);
        zr = zeros(20,r);
        result = [zl img zr];
    else
        result = imresize(img,[20,20]);
    end
end


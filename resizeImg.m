function [ result ] = resizeImg( img )
%RESIZEIMG 此处显示有关此函数的摘要
%   此处显示详细说明

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


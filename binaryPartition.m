function [ letters ] = binaryPartition( img, num )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明

    letters = zeros(num,400);
    img = rgb2gray(img);%灰度化
    img = im2bw(img);%0-1二值化
    img = 1-img;%颜色反转让字符成为联通域，方便去除噪点
    points=partitionPoint(img,num);
    for j = 0:num-1
        region = [points(j+1,1),1,points(j+1,2),20];
        subimg = imcrop(img,region);
        imlabel = bwlabel(subimg);
        m=max(max(imlabel));
        if m>1 % 说明有噪点，要去除
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area); 
            maxindex = find(area == max(area));
            area(maxindex) = 0;
            for ii=1:m-1
                secondindex = find(area == max(area));        
                imindex = ismember(imlabel,secondindex);
                subimg(imindex==1)=0;%去掉第二大连通域，噪点不可能比字符大，所以第二大的就是噪点
            end
        end
        subimg = resizeImg(subimg);
        minwidth = 20;
        for angle = -60:60
            imgr=imrotate(subimg,angle,'bilinear','crop');%crop 避免图像大小变化
            imlabel = bwlabel(imgr);
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area);
            maxindex = find(area == max(area));
            imindex = ismember(imlabel,maxindex);%最大连通域为1
            [~,x] = find(imindex==1);
            width = max(x)-min(x)+1;
            if width<minwidth
                minwidth = width;
                imgrr = imgr;
            end
        end
        letter = im2bw(imgrr);
        letters(j+1,:) = letter(:);
    end
end
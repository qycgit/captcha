function [ letters ] = binaryPartition( img, num )
%binaryPartition image binaryzation and partition
%   letters -- result array a row is a letter
%   img -- image
%   num -- the number of letters

    letters = zeros(num,400);
    img = rgb2gray(img);%gray
    img = im2bw(img);%0-1 binaryzation
    img = 1-img;%Color reversal, to facilitate removal of noise
    points=partitionPoint(img,num);
    for j = 0:num-1
        region = [points(j+1,1),1,points(j+1,2),20];
        subimg = imcrop(img,region);
        imlabel = bwlabel(subimg);
        m=max(max(imlabel));
        if m>1 % The number of connected regions is greater than 1, indicating noise to be removed
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area); 
            maxindex = find(area == max(area));
            area(maxindex) = 0;
            for ii=1:m-1
                secondindex = find(area == max(area));        
                imindex = ismember(imlabel,secondindex);
                %Remove the second largest connected domain, the noise can not be larger than the characters
                subimg(imindex==1)=0;
            end
        end
        %Resize the image to 20*20
        subimg = resizeImg(subimg);
        minwidth = 20;
        %Rotate the image around 60 degrees, taking the smallest angle of the character width
        for angle = -60:60
            imgr=imrotate(subimg,angle,'bilinear','crop');
            imlabel = bwlabel(imgr);
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area);
            maxindex = find(area == max(area));
            imindex = ismember(imlabel,maxindex);
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
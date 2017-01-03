%create training data. 
%training data partition 
mydir='.\bw\';
lettersdir = '.\letters\';
if exist(lettersdir,'dir')==0
    mkdir(lettersdir);
end
DIRS=dir([mydir,'*.jpg']);
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(mydir,DIRS(i).name ));
        img = im2bw(img);%0-1 binaryzation
        img = 1-img;%Color reversal, to facilitate removal of noise
        points=partitionPoint(img,4);
        for j = 0:3
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
            name = strcat(lettersdir,DIRS(i).name(j+1),'_',num2str(i*4+j),'.jpg');
            %Resize the image to 20*20
            subimg = resizeImg(subimg);
            imwrite(subimg,name);
        end
    end
end
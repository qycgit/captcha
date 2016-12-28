mydir='.\letters\';
rotateDir='.\rotateLetter\';
if exist(rotateDir,'dir')==0
    mkdir(rotateDir);
end
DIRS=dir([mydir,'*.jpg']);  %扩展名
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(mydir,DIRS(i).name ));
        img = im2bw(img);
        minwidth = 20;
        for angle = -60:60
            imgr=imrotate(img,angle,'bilinear','crop');%crop 避免图像大小变化
            imlabel = bwlabel(imgr);
            stats = regionprops(imlabel,'Area');
            area = cat(1,stats.Area);
            maxindex = find(area == max(area));
            imindex = ismember(imlabel,maxindex);%最大连通域为1
            [y,x] = find(imindex==1);
            width = max(x)-min(x)+1;
            if width<minwidth
                minwidth = width;
                imgrr = imgr;
            end
        end
        name = strcat(rotateDir,DIRS(i).name);
        imwrite(imgrr,name);
    end
end
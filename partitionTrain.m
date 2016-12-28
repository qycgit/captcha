mydir='.\bw\';
lettersdir = '.\letters\';
if exist(lettersdir,'dir')==0
    mkdir(lettersdir);
end
DIRS=dir([mydir,'*.jpg']);  %扩展名
n=length(DIRS);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(mydir,DIRS(i).name ));
        img = im2bw(img);%二值化
        img = 1-img;%颜色反转让字符成为联通域，方便去除噪点
        for j = 0:3
            region = [j*20+1,1,19,20];%把一张验证码分成四个20*20大小的字符图片
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
            name = strcat(lettersdir,DIRS(i).name(j+1),'_',num2str(i*4+j),'.jpg');
            imwrite(subimg,name);
        end
    end
end
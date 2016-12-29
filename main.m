testDir='.\testcaptcha\';
trainDir='.\rotateLetter\';

%load train data
DIRS=dir([trainDir,'*.jpg']);
n=length(DIRS);
traindata=zeros(n,400);
trainlabel = char(n);
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(trainDir,DIRS(i).name));
        img = im2bw(img);
        traindata(i,:)=img(:);
        trainlabel(i)=DIRS(i).name(1);
    end
end

%test
DIRS=dir([testDir,'*.jpg']);
n=length(DIRS);
sum = 0;
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(testDir,DIRS(i).name ));
        letters = binaryPartition(img,4);
%         imshow(letters{1,1});
        result = KNN(letters,traindata, trainlabel,5);
        disp(['result:',result,'real:',DIRS(i).name(1:4)]);
        if strcmp(result,DIRS(i).name(1:4))
            sum = sum+1;
        end
    end
end
sum
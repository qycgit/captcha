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

%bpnn training
eta=0.01;
maxIte=2000;
targetE=1e-5;
[ netV,netW,netR,netA] = BPNNTrain(traindata,trainlabel,eta,maxIte,targetE);

knnsum = 0;
knnsumsingle = 0;
BPnnsum = 0;
BPnnsumsingle = 0;
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(testDir,DIRS(i).name ));
        letters = binaryPartition(img,4);
        
        %knn
%         knnresult = KNN(letters,traindata, trainlabel,1);
%         if strcmp(knnresult,DIRS(i).name(1:4))
%             knnsum = knnsum+1;
%         end
%         for j = 1:4
%             if strcmp(knnresult(j),DIRS(i).name(j))
%                 knnsumsingle = knnsumsingle+1;
%             end
%         end
        
        %bpnn
        bpnnresult = BPNNPre(letters,netV,netW,netR,netA);
        if strcmp(bpnnresult,DIRS(i).name(1:4))
            BPnnsum = BPnnsum+1;
        end
        for j = 1:4
            if strcmp(bpnnresult(j),DIRS(i).name(j))
                BPnnsumsingle = BPnnsumsingle+1;
            end
        end
        
    end
end





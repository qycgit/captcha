function [resultTable,testImgs,resultLabels] = testDataPre(trainFlag)
%Calculate the results of the test data
%resultTable -- the accuracy rate of each method 
%testImgs -- test data
%resultLabels -- result of test data ,first column is the result of KNN,
%second column is the result of BPNN
%trainFlag -- whether to retrain the neural network

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
testImgs = cell(n,1);
resultLabels = cell(n,2);

%bpnn training
if trainFlag
    eta=0.05;
    maxIte=5;
    targetE=1e-5;
    [ netV,netW,netR,netA] = BPNNTrain(traindata,trainlabel,eta,maxIte,targetE);
else
    load('NNweight.mat');
end

knnsum = 0;
knnsumsingle = 0;
BPnnsum = 0;
BPnnsumsingle = 0;
for i=1:n
    if ~DIRS(i).isdir
        img = imread(strcat(testDir,DIRS(i).name ));
        testImgs{i,1}=img;
        letters = binaryPartition(img,4);
        
        %knn
        knnresult = KNN(letters,traindata, trainlabel,1);
        resultLabels{i,1} = knnresult;
        if strcmp(knnresult,DIRS(i).name(1:4))
            knnsum = knnsum+1;
        end
        for j = 1:4
            if strcmp(knnresult(j),DIRS(i).name(j))
                knnsumsingle = knnsumsingle+1;
            end
        end
        
        %bpnn
        bpnnresult = BPNNPre(letters,netV,netW,netR,netA);
        resultLabels{i,2} = bpnnresult;
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

%accuracy rate
knnsum = knnsum/n;
knnsumsingle = knnsumsingle/(n*4);
BPnnsum = BPnnsum/n;
BPnnsumsingle = BPnnsumsingle/(n*4);
%gui result table
resultTable = {knnsumsingle knnsum n; BPnnsumsingle BPnnsum n};

end







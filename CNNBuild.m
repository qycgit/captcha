function [ cnn ] = CNNBuild( traindata,trainlabel,opts)
%CNNBuild build and train cnn model
%   

    m = size(traindata,1);
    %output data init
    y = zeros(m,33);
    for i =1 :m
        label =trainlabel(i);
        if label<='9'
            y(i,label-'1') = 1;
        elseif label<'I'
            y(i,label-'1'-7) = 1;
        else
            y(i,label-'1'-8) = 1;
        end
    end
    traindata = reshape(traindata',20,20,m);
    y = y';
    
    %cnn init
    cnn.layers = {
        struct('type', 'i') %input layer
        struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
        struct('type', 's', 'scale', 2) %sub sampling layer
        struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
        struct('type', 's', 'scale', 2) %sub sampling layer
    };
    cnn = cnnsetup(cnn, traindata, y);
    cnn = cnntrain(cnn, traindata, y, opts);
end


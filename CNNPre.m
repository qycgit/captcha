function [ result ] = CNNPre( letters,cnn)
%myCNNPre 此处显示有关此函数的摘要
%   此处显示详细说明

    letters = reshape(letters',20,20,4);
    cnn = cnnff(cnn,letters);
    [~,temp] = max(cnn.o);
    result = char(4);
    for i = 1:4
        if temp(i)<=8
            result(i)=char(temp(i)+'1');
        elseif temp(i)<=16
            result(i)=char(temp(i)+7+'1');
        else
            result(i)=char(temp(i)+8+'1');
        end
    end

end


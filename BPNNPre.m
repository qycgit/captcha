function [ result ] = BPNNPre( letters,netV,netW,netR,netA)
%BPNNPre bpnn prediction
%   result -- result
%   letters -- letters to recognize
%   netV -- The weight from input layer to hidden layer
%   netW -- The weight from hidden layer to output layer
%   netR -- The bias of hidden layer
%   netA -- The bias of output layer

    x1=letters*netV;
    y1=1./(1+exp(-(x1-netR)));
    x2=y1*netW;
    y2=1./(1+exp(-(x2-netA)));
    [~,temp]=min((y2-1).^2,[],2);
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


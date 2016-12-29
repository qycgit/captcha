function [ result ] = KNN( letters, traindata, trainlabel, k)
%KNN 此处显示有关此函数的摘要
%   此处显示详细说明

    klabel = char(k);
    kdistance = zeros(k,1);
    n = size(letters,1);
    m = size(traindata,2);
    total = size(traindata,1);
    result = char(n);
    
    for i=1:n
        for j=1:k
            kdistance(j)=500;
            klabel(j)='A';
        end
        
        for j=1:total
            %calculate distance between two letter
            d = abs(traindata(j,:)-letters(i,:));
            d = sum(d);
            
            %k nearest neighbor
            tlabel = trainlabel(j);
            for l=1:k
                if d<kdistance(l)
                    dtemp = kdistance(l);
                    ltemp = klabel(l);
                    kdistance(l) = d;
                    klabel(l) = tlabel;
                    d = dtemp;
                    tlabel = ltemp;
                end
            end
        end
        
        lmap = containers.Map();
        dmap = containers.Map();
        dsum = 0;
        for j=1:k
            if lmap.isKey(klabel(j))
                dmap(klabel(j)) = dmap(klabel(j)) + kdistance(j);
                lmap(klabel(j)) = lmap(klabel(j))+1;
            else
                dmap(klabel(j)) = kdistance(j);
                lmap(klabel(j)) = 1;
            end
            dsum = dsum + kdistance(j);
        end
        ta = tabulate(klabel(:));
        [~,index] = max([ta{:,2}]);
        result(i) = ta{index,1};
    end
end


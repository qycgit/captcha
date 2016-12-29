function [ result ] = KNN( letters, traindata, trainlabel, k)
%KNN KNN function
%   result -- result
%   letters -- letters to recognize
%   traindata -- training data
%   trainlabel -- the label of training data
%   k -- k nearest neighbors

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
        ta = tabulate(klabel(:));
        [~,index] = max([ta{:,2}]);
        result(i) = ta{index,1};
    end
end


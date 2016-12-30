function [ points ] = partitionPoint( img ,num)
%PARTITIONPOINT find partiton point use CFS,Connected field segmentation
%   points -- partiton points
%   img -- image
%   num -- the number of letters

   temp = [];
   imlabel = bwlabel(img);
   stats = regionprops(imlabel,'Area');
   area = cat(1,stats.Area);
   for i=1:num
       maxindex = find(area == max(area));
       maxindex = maxindex(1);
       area(maxindex)=0;
       memindex = ismember(imlabel,maxindex);
       [~,x] = find(memindex==1);
       temp(i,1) = min(x);
       temp(i,2) = max(x)-min(x)+1;
   end
   [~,index] = sort(temp(:,1));
   points = temp(index,:);
end


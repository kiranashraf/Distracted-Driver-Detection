function [ isC8] = isDistractedC8( ang,totDistance )
%Detect whether an image belogs to class 9
% That is c0: Not Distracted

isC8='N';

% if(ang == 60 || ang == inf)     
        if(totDistance(1)< 200 && totDistance(2)> 200)
            isC8='Y';
        end
%end

end


function [ isC0 ] = isDistractedC0( ang,totDistance,headInd )
%Detect whether an image belogs to class 0
% That is c0: Not Distracted

isC0='N';

%if(ang >= 60)
    if(headInd == 1)      
        if(totDistance(1)> 180 && totDistance(2)> 200 && totDistance(3)< 200 )
            isC0='Y';
        end
    end
%end

end


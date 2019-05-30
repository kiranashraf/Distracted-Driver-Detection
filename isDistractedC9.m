function [ isC9] = isDistractedC9( ang,totDistance,headInd )
%Detect whether an image belogs to class 9
% That is c0: Not Distracted

isC9='N';

if(ang <= 60)
    if(headInd == 1)      
        if(totDistance(1)> 200 && totDistance(2)> 200)
            isC9='Y';
        end
    end
end

end


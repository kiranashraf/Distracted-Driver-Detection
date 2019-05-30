function [ isDistracted] = isDistractedDrinking( im )
%Detect whether a person is using cellphone

    isDistracted = isDistractedC5( im );
    if(isDistracted ~= 'Y')
        isDistracted = isDistractedDrink( im );
    end
    
end




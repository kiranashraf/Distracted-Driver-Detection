function [ isDistracted] = isDistractedSMS( im )
%Detect whether a person is using cellphone

    isDistracted = isDistractedC1( im );
    if(isDistracted ~= 'Y')
        isDistracted = isDistractedC3( im );
        if(isDistracted ~= 'Y')
            isDistracted = isDistractedMobile( im );
        end
    end
    
end




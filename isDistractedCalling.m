function [ isDistracted] = isDistractedCalling( im )
%Detect whether a person is using cellphone

    isDistracted = isDistractedC4( im );
    if(isDistracted ~= 'Y')
        isDistracted = isDistractedC2( im );
    end
    
end




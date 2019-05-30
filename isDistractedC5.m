function [ isC5] = isDistractedC5( im )
%Detect whether an image belogs to class 5
% That is c1: texting - right

    detector_hog = vision.CascadeObjectDetector('pos_Drinking_HOG.xml');
    %detector_haar = vision.CascadeObjectDetector('pos_Drinking_Haar.xml');
    detector_lbp = vision.CascadeObjectDetector('pos_Drinking_LBP.xml');

    bbox_hog = step(detector_hog, im);
    %bbox_haar = step(detector_haar, im);
    bbox_lbp = step(detector_lbp, im);

    vote_count = 0;

    if(~isempty(bbox_hog))
        vote_count = vote_count+1;
    end

%     if(~isempty(bbox_haar))
%         vote_count = vote_count+1;
%     end

    if(~isempty(bbox_lbp))
        vote_count = vote_count+1;
    end

    isC5 = 'N';
    if(vote_count == 2)
         isC5 = 'Y';
    end
end



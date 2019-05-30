function [ isC1] = isDistractedMobile( im )
%Detect whether an image belogs to class 1
% That is c1: texting - right

    detector_hog = vision.CascadeObjectDetector('pos_SMS_HOG.xml');
    detector_haar = vision.CascadeObjectDetector('pos_SMS_Haar.xml');
    detector_lbp = vision.CascadeObjectDetector('pos_SMS_LBP.xml');

    bbox_hog = step(detector_hog, im);
    bbox_haar = step(detector_haar, im);
    bbox_lbp = step(detector_lbp, im);

    vote_count = 0;

    if(~isempty(bbox_hog))
        vote_count = vote_count+1;
%         IFaces = insertObjectAnnotation(im, 'rectangle', bbox_hog, 'Face');
%         figure, imshow(IFaces), title('Detected SMS');
    end

%     if(~isempty(bbox_haar))
%         vote_count = vote_count+1;
%         IFaces = insertObjectAnnotation(im, 'rectangle', bbox_haar, 'Face');
%         figure, imshow(IFaces), title('Detected SMS');
%     end
% 
%     if(~isempty(bbox_lbp))
%         vote_count = vote_count+1;
%         IFaces = insertObjectAnnotation(im, 'rectangle', bbox_lbp, 'Face');
%         figure, imshow(IFaces), title('Detected SMS');
%     end
    
    isC1 = 'N';
    if(vote_count >= 1)
         isC1 = 'Y';
    end
end




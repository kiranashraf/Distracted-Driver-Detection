function [ isDistracted] = isDistractedDrink( im )
%Detect whether a person is using cellphone
detector_hog = vision.CascadeObjectDetector('pos_Drink_HOG.xml');
detector_lbp = vision.CascadeObjectDetector('pos_SMS_LBP.xml');

    bbox_hog = step(detector_hog, im);
    bbox_lbp = step(detector_lbp, im);

    vote_count = 0;

    if(~isempty(bbox_hog))
%          IFaces = insertObjectAnnotation(im, 'rectangle', bbox_hog, 'Face');
%         figure, imshow(IFaces), title('Detected SMS');
        vote_count = vote_count+1;
    end
    
    if(~isempty(bbox_lbp))
        vote_count = vote_count+1;
%         IFaces = insertObjectAnnotation(im, 'rectangle', bbox_lbp, 'Face');
%         figure, imshow(IFaces), title('Detected SMS');
    end
    
    isDistracted = 'N';
    if(vote_count >= 1)
         isDistracted = 'Y';
    end
    
end




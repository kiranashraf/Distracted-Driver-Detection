function [ croppedImg ] = getCroppedFace( I )
%GETCROPPEDFACE Summary of this function goes here
%   Detailed explanation goes here

 FDetect_Haar = vision.CascadeObjectDetector('pos_profile_Haar4.xml');
 FDetect_Haar.MergeThreshold = 40;
 FDetect_Haar.MinSize = [60 60];
 
 FDetect_HOG = vision.CascadeObjectDetector('pos_profile_HOG3.xml');
 FDetect_Haar.MergeThreshold = 40;
 FDetect_HOG.MinSize = [60 60];
 
 FDetect_LBP = vision.CascadeObjectDetector('pos_profile_LBP4.xml');
 FDetect_LBP.MergeThreshold = 40;
 FDetect_LBP.MinSize = [60 60];

 cc= [ 110 100 9999 9999];
    
 BB_Haar = step(FDetect_Haar,I);
 BB_HOG = step(FDetect_HOG,I);
 BB_LBP = step(FDetect_LBP,I);
    
 if(~isempty(BB_LBP))
    cc = min(cc , BB_LBP(1,:));
 end
 if(~isempty(BB_Haar))
    cc = min(cc , BB_Haar(1,:));
 end
 if(~isempty(BB_HOG)) 
    cc = min(cc , BB_HOG(1,:));
 end
  cc(1) = cc(1)-50;
  cc(2) = cc(2)-50;
  cc(3) = cc(3)+120+50;
  cc(4) = cc(4)+120+50;
     
  if(~isempty(cc))
     %detectedImg = insertObjectAnnotation(im, 'rectangle', cc, 'driver');
     croppedImg = imcrop(I,cc);
  end
end



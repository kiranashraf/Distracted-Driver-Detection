function DistractedDriverDetection1( )
%DISTRACTEDDRIVERDETECTION Summary of this function goes here
%   Detailed explanation goes here
close all
 P = addpath('../driverPics/C5');
 %P = addpath('../train/c0')
 %ims = dir('../minTestImg/*.jpg');
 ims = dir('../driverPics/C5/*.jpg');
addpath('models');
[ model,posemap ] = init();

% read data from CSV file to write
%[img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9] = importCSVfile('sample_submission.csv',2, 79727);
classList = cell(length(ims),2);
acc = 0;
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([ims(i).name]);
    im = imresize(im, [nan 640],'nearest');
    im = flip(im,1);
    isC1 = isDistractedDrink( im );
        if(isC1 == 'Y')
            acc = acc+1;
            %figure,imshow(im)
        end
            
%       try
%         [~,maskedRGBImage] = createMask5(im);
%     catch
%         maskedRGBImage=I;
%       end
    
    %getSkinRegion( im );
    %[BW,maskedRGBImage] = createMask(im);
    %figure,imshow(maskedRGBImage)
     %detectSkin(im);
     %detectTestSkin(im);
     %a= getSkinRegion(im);
    %figure,imshow(a)

end
fprintf('Accuracy: %f\n',(acc)/length(ims)*100 );
save('result5.mat','classList');


% T = table(img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9);
% writetable(T,'t2.csv','WriteRowNames',true);

end


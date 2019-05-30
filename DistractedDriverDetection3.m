function DistractedDriverDetection3( )
%DISTRACTEDDRIVERDETECTION Summary of this function goes here
%   Detailed explanation goes here
close all
P = addpath('../FinalTestSet/TestSet');
ims = dir('../FinalTestSet/TestSet/*.jpg');
addpath('models');
[ model,posemap ] = init();

classList = cell(length(ims),3);
acc = 0;
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([ims(i).name]);
    im = imresize(im, [nan 640],'nearest');
    im = flip(im);
    classList(i,1) = {ims(i).name};
    clas= '';
    aclass = '';
    isDistracted = isDistractedSMS( im );
    if(isDistracted == 'Y')
        clas='C2C4';
    else
        isDistracted = isDistractedCalling( im );
        if(isDistracted == 'Y')
            clas='C1C3';
        else
            I = getCroppedFace(im);
            ang = faceOrientation(I,model,posemap)
            if(ang < 60)
                isDistracted='Y';
                clas = 'C7';
                acc=acc+1;
            else
                isDistracted = isDistractedDrinking( im );
                if(isDistracted == 'Y')
                    clas = 'C5';
                else
                    clas = 'C0';
                    isDistracted = 'N';
                end
            end
        end
    end
    classList(i,2) = {clas};
    classList(i,3) = {isDistracted};
    
    if(strcmp(clas,'C0') ~= 1)
        fprintf('Warning!! The Driver is Distracted' );
        fprintf('\n belongs to Distraction class %s\n',clas );
    else
        fprintf('Yeah!! The Driver is not Distracted\n' );
    end
end

%fprintf('Accuracy: %f\n',(acc)/length(ims)*100 );
save('result1.mat','classList');

end


function DistractedDriverDetection1( )
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
        clas='C1C3';
        %acc = acc+1;
        %figure,imshow(im)
    else
        %figure,imshow(im)
        isDistracted = isDistractedCalling( im );
        if(isDistracted == 'Y')
            clas='C2C4';
            %acc=acc+1;
        else
            I = getCroppedFace(im);
            %figure,imshow(I)
            ang = faceOrientation(I,model,posemap)
            isDistracted='N';
            if(ang < 60)
                isDistracted='Y';
                clas = 'C7';
                %acc=acc+1;
            else
                isDistracted = isDistractedDrinking( im );
                if(isDistracted == 'Y')
                    clas = 'C5';
                    acc=acc+1;
                else
                    clas = 'C0';
                    %acc = acc+1;
                end
            end
        end
    end
    classList(i,2) = {clas};
    classList(i,3) = {isDistracted};
    % %    if(exist(strcat('C:\matlabWorkspace\myTest\',clas,'\',ims(i).name), 'file') == 2)
    % %        acc = acc +1;
    % %    elseif(exist(strcat('C:\matlabWorkspace\myTest\',aclass,'\',ims(i).name), 'file') == 2)
    % %            acc = acc +1;
    % %    end
    % if(exist(strcat('C:\matlabWorkspace\train\',clas,'\',ims(i).name), 'file') == 2)
    %         acc = acc +1;
    % end
    
    if(strcmp(clas,'') == 1)
        %figure,imshow(im)
    end
    
    if(strcmp(clas,'C0') ~= 1)
        fprintf('Warning!! The Driver is Distracted' );
        fprintf('\n belongs to Distraction class %s\n',clas );
        %figure,imshow(im)
    else
        fprintf('Yeah!! The Driver is not Distracted\n' );
        %figure,imshow(im)
    end
    
end
fprintf('Accuracy: %f\n',(acc)/length(ims)*100 );
save('resultHOGLBP.mat','classList');


% T = table(img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9);
% writetable(T,'t2.csv','WriteRowNames',true);

end


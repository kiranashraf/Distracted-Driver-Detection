function distractedDriverDetectionJugad( )
%DISTRACTEDDRIVERDETECTION Summary of this function goes here
%   Detailed explanation goes here
close all
P = addpath('../minTestImg\TestSet\');
% P = addpath('../myTest/C9');
%P = addpath('../train/c0')
ims = dir('../minTestImg/TestSet\*.jpg');
%ims = dir('../myTest/C9/*.jpg');
addpath('models');
[ model,posemap ] = init();

% read data from CSV file to write
%[img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9] = importCSVfile('sample_submission.csv',2, 79727);
classList = cell(length(ims),2);
acc = 0;
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([ims(i).name]);
    classList(i,1) = {ims(i).name};
    clas= '';
    aclass = '';
    isDistracted = isDistractedC1( im );
    if(isDistracted == 'Y')
        clas='C1C3';
    else
        isDistracted = isDistractedC3( im );
        if(isDistracted == 'Y')
            clas='C1C3';
        else
            isDistracted = isDistractedC4( im );
            if(isDistracted == 'Y')
                clas='C2C4';
            else
                isDistracted= isDistractedC2( im );
                if(isDistracted == 'Y')
                    clas='C2C4';
                else
                    isDistracted = isDistractedC5( im );
                    if(isDistracted == 'Y')
                        clas = 'C5';
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
                            clas = 'C0';
                            %acc = acc+1;
                        end
                    end
                end
            end
        end
    end
    classList(i,2) = {clas};
    classList(i,3) = {isDistracted};
    
    if(exist(strcat('C:\matlabWorkspace\myTest\',clas,'\',ims(i).name), 'file') == 2)
        acc = acc +1;
    elseif(exist(strcat('C:\matlabWorkspace\myTest\',aclass,'\',ims(i).name), 'file') == 2)
        acc = acc +1;
    end
    % if(exist(strcat('C:\matlabWorkspace\train\',clas,'\',ims(i).name), 'file') == 2)
    %         acc = acc +1;
    % end
    
    
    if(strcmp(clas,'C0') ~= 1)
        fprintf('Warning!! The Driver is Distracted' );
        fprintf('\n belongs to Distraction class %s\n',clas );
    else
        fprintf('Yeah!! The Driver is not Distracted\n' );
    end
    
end
fprintf('Accuracy: %f\n',(acc)/length(ims)*100 );
save('resultListKaggleHaarLBP.mat','classList');


% T = table(img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9);
% writetable(T,'t2.csv','WriteRowNames',true);

end


function distractedDriverDetection( )
%DISTRACTEDDRIVERDETECTION Summary of this function goes here
%   Detailed explanation goes here

P = addpath('../test');
ims = dir('../test/*.jpg');
addpath('models');
[ model,posemap ] = init();
ang = -999;
% read data from CSV file to write
[img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9] = importCSVfile('t3.csv',2, 79727);

for i = 60001:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([ims(i).name]);
        isC1 = isDistractedC1( im );
        if(isC1 == 'Y')
            c3(i) = 0.6; c1(i) = 0.32; c0(i) = 0.01; c2(i) = 0.01; c4(i) = 0.01;
            c5(i) = 0.01; c6(i) = 0.01; c7(i) = 0.01; c8(i) = 0.01; c9(i) = 0.01; 
        else
            isC3 = isDistractedC3( im );
            if(isC3 == 'Y')
                c1(i) = 0.6; c3(i) = 0.32; c0(i) = 0.01; c2(i) = 0.01; c4(i) = 0.01;
                c5(i) = 0.01; c6(i) = 0.01; c7(i) = 0.01; c8(i) = 0.01; c9(i) = 0.01;
            else
                isC4 = isDistractedC4( im );
                if(isC4 == 'Y')
                    c4(i) =0.85; c1(i) = 0.0167; c3(i) = 0.0167; c0(i) = 0.0167; c2(i) = 0.0167; 
                    c5(i) = 0.0167; c6(i) = 0.0167; c7(i) = 0.0167; c8(i) = 0.0167; c9(i) = 0.0167;
                else
                    isC2= isDistractedC2( im );
                    if(isC2 == 'Y')
                        c2(i) =0.80; c1(i) = 0.0150; c3(i) = 0.0150; c0(i) = 0.02; c4(i) = 0.05; 
                        c5(i) = 0.02; c6(i) = 0.02; c7(i) = 0.02; c8(i) = 0.02; c9(i) = 0.02;
                    else
                        isC5 = isDistractedC5( im );
                        if(isC5 == 'Y')
                            c5(i) =0.80; c1(i) = 0.0125; c3(i)= 0.0125; c0(i) = 0.0300; c4(i) = 0.0125; 
                            c2(i) = 0.0125; c6(i) = 0.0300; c7(i) = 0.0300; c8(i) = 0.0300; c9(i) = 0.0300;
                        else
%                             im = getCroppedFace(im);
%                             ang = faceOrientation(im,model,posemap);
                            [totDistance, headInd] = getHeadArmsDistance( im );
                            isC0 = isDistractedC0( ang,totDistance,headInd );
                            if(isC0 == 'Y')
                                c0(i) =0.45; c1(i) = 0.008; c3(i)= 0.008; c5(i) = 0.008; c4(i) = 0.008; 
                                c2(i) = 0.0125; c6(i) = 0.0200; c7(i) = 0.0200; c8(i) = 0.0200; c9(i) = 0.45;
                            else
%                                  isC9 = isDistractedC9( ang,totDistance,headInd );
%                                  if(isC9 == 'Y')
%                                       c9(i) =0.80; c1(i) = 0.01; c3(i)= 0.01; c5(i) = 0.01; c4(i) = 0.01; 
%                                       c2(i) = 0.01; c6(i) = 0.0333; c7(i) = 0.0333; c8(i) = 0.0333; c0(i) = 0.05;
%                                  else
                                     isC8 = isDistractedC8( ang,totDistance );
                                     if(isC8 == 'Y')
                                         c9(i) =0.01; c1(i) = 0.01; c3(i)= 0.01; c5(i) = 0.01; c4(i) = 0.01; 
                                         c2(i) = 0.01; c6(i) = 0.13; c7(i) = 0.15; c8(i) = 0.65; c0(i) = 0.01;
                                     else
                                          c9(i) =0.01; c1(i) = 0.01; c3(i)= 0.01; c5(i) = 0.01; c4(i) = 0.01; 
                                         c2(i) = 0.01; c6(i) = 0.47; c7(i) = 0.45; c8(i) = 0.01; c0(i) = 0.01;
                                     end
                                 end
                            end
                        end
                    end
                end
        end
end

T = table(img,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9);
writetable(T,'t4.csv','WriteRowNames',true);

end


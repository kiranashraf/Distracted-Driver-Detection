function imgFeat = driversFaceFeat()

    % compile.m
    compile;

    % load and visualize model
    % Pre-trained model with 146 parts. Works best for faces larger than 80*80
     load face_p146_small.mat

     % 5 levels for each octave
    model.interval = 5;
    % set up the threshold
    model.thresh = min(-0.65, model.thresh);

    % define the mapping from view-specific mixture id to viewpoint
    if length(model.components)==13 
        posemap = 90:-15:-90;
    elseif length(model.components)==18
        posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
    else
        error('Can not recognize this model');
    end
    a = load('ImgFeat.mat');
    imgFeat = a.imgFeat;
    %imgFeat = cell(22424, 3);
    %imgFeat(:,1) = {'test'};
    %imgFeat(:,2) = {'test'};
    %imgFeat(:,3) = {'test'};
	%imgFeat = zeros(25000, 10000);
    %for j = 0 : 9
        %imgClass = strcat('c', num2str(j));
        imgClass = 'c2';
        ims = dir(strcat('../train/c2/*.jpg'));
        j= 2490;
        for i = 1:length(ims),
            fprintf('testing: %d/%d\n', i, length(ims));
            im = imread([ims(i).name]);
            im = imresize(im,0.7);
            %clf; imagesc(im); axis image; axis off; drawnow;

            tic;
            bs = detect(im, model, model.thresh);
            bs = clipboxes(im, bs);
            bs = nms_face(bs,0.3);
            dettime = toc;

            % show highest scoring one
            %figure,showboxes(im, bs(1),posemap),title('Highest scoring detection');
            % show all
             % figure,
            imPos = showboxes(im, bs,posemap);
            fprintf('Class %s, Image name: %s , Rot: %s\n', imgClass , ims(i).name, imPos);
            imgFeat(j,:) = {imgClass , ims(i).name, imPos};
            j = j+1;    
            %title('All detections above the threshold');

            fprintf('Detection took %.1f seconds\n',dettime);
            %close all;
       % end
        end
    save('ImgFeat.mat','imgFeat');
    disp('done!');
end

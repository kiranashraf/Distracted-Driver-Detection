function [ impos ] = faceOrientation( im, model, posemap)
    
    %clf; imagesc(im); axis image; axis off; drawnow;
    
    tic;
    bs = detect(im, model, model.thresh);
    bs = clipboxes(im, bs);
    bs = nms_face(bs,0.3);
    dettime = toc;
    
    % show highest scoring one
    %figure,showboxes(im, bs(1),posemap),title('Highest scoring detection');
    % show all
    %figure,
    impos = getFaceAngle(bs,posemap);
    %impos = showboxes(im, bs,posemap)
    %,title('All detections above the threshold');
    
    fprintf('Detection took %.1f seconds\n',dettime);


end


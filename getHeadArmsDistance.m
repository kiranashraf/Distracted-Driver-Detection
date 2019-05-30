function [ totDistance, headInd ] = getHeadArmsDistance( im )
%GETHEADARMSDISTANCE Summary of this function goes here
%   Detailed explanation goes here

    [ I,~ ] = cropBackSeatPerson( im );
    [ I,Xmin ] = cropBackSeatPerson( I );
    
    try
        [~,maskedRGBImage] = createMask5(I);
    catch
        maskedRGBImage=I;
    end
    figure, imshow(maskedRGBImage);
    [ a ] = getSkinRegion( maskedRGBImage );

    BW = im2bw(a, 0.2);
    
    CC = bwconncomp(BW);
    totDistance = [0,0,0];
    headInd = 0;
    if(CC.NumObjects > 1)
        
        [Xout, ~] = getLargestCc(BW, [], 3);
        figure, imshow(BW)

        s  = regionprops(Xout, 'centroid');
        
        distance = [sqrt((Xmin(1)-s(1).Centroid(1)).^2+(Xmin(2)-s(1).Centroid(2)).^2)..., 
        sqrt((Xmin(1)-s(2).Centroid(1)).^2+(Xmin(2)-s(2).Centroid(2)).^2)...,
        sqrt((Xmin(1)-s(3).Centroid(1)).^2+(Xmin(2)-s(3).Centroid(2)).^2)];

        [~, headInd] = min(distance);

        totDistance = [sqrt((s(1).Centroid(1) - s(2).Centroid(1)).^2+(s(1).Centroid(2) - s(2).Centroid(2)).^2)..., 
        sqrt((s(1).Centroid(1) - s(3).Centroid(1)).^2+(s(1).Centroid(2) - s(3).Centroid(2)).^2)...,
        sqrt((s(2).Centroid(1) - s(3).Centroid(1)).^2+(s(2).Centroid(2) - s(3).Centroid(2)).^2)];
    
        centroids = cat(1, s.Centroid);
        figure,imshow(BW)
        hold on
        plot(centroids(:,1), centroids(:,2), 'b*')
        hold off
    end
end


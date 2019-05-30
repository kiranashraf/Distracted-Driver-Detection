function  detectSkin( I )
[ I,Xmin ] = cropBackSeatPerson( I );
I=double(I);
[hue,s,v]=rgb2hsv(I);
cb =  0.148* I(:,:,1) - 0.291* I(:,:,2) + 0.439 * I(:,:,3) + 128;
cr =  0.439 * I(:,:,1) - 0.368 * I(:,:,2) -0.071 * I(:,:,3) + 128;
[w h]=size(I(:,:,1));
for i=1:w
    for j=1:h            
        if  140<=cr(i,j) && cr(i,j)<=165 && 140<=cb(i,j) && cb(i,j)<=195 && 0.01<=hue(i,j) && hue(i,j)<=0.1     
            segment(i,j)=1;            
        else       
            segment(i,j)=0;    
        end    
    end
end

im(:,:,1)=I(:,:,1).*segment;   
im(:,:,2)=I(:,:,2).*segment; 
im(:,:,3)=I(:,:,3).*segment; 

BW = im2bw(im, 0.2);

figure,imshow(im);
%BW = bwareaopen(BW, 50);
CC = bwconncomp(BW);

% remove smallest object
numPixels = cellfun(@numel,CC.PixelIdxList);
[~,idx] = min(numPixels);
BW(CC.PixelIdxList{idx}) = 0;

%BW = bwdist(BW) <= 4;

%figure, imshow(BBW);
BW = bwdist(BW) <= 0.5;
[Xout, ~] = getLargestCc(BW, [], 4);
[Xout1, ~] = getLargestCc(BW, [], 3);

%Xout = bwdist(Xout) <= 6.5;
Xout = bwdist(Xout) <= 2;

[Xout, ~] = getLargestCc(Xout, [], 3);
figure, imshow(Xout);

s  = regionprops(Xout, 'centroid');

try
    distance = [sqrt((Xmin(1)-s(1).Centroid(1)).^2+(Xmin(2)-s(1).Centroid(2)).^2)..., 
        sqrt((Xmin(1)-s(2).Centroid(1)).^2+(Xmin(2)-s(2).Centroid(2)).^2)...,
        sqrt((Xmin(1)-s(3).Centroid(1)).^2+(Xmin(2)-s(3).Centroid(2)).^2)];
catch
    s  = regionprops(Xout1, 'centroid');
    distance = [sqrt((Xmin(1)-s(1).Centroid(1)).^2+(Xmin(2)-s(1).Centroid(2)).^2)..., 
        sqrt((Xmin(1)-s(2).Centroid(1)).^2+(Xmin(2)-s(2).Centroid(2)).^2)...,
        sqrt((Xmin(1)-s(3).Centroid(1)).^2+(Xmin(2)-s(3).Centroid(2)).^2)];
end

[~, headInd] = min(distance)
cnt = 0;
if headInd >1
    %cnt= cnt+1;
    figure, imshow(Xout)
end
   
        %figure,imshow(Xout)
% if(CC.NumObjects > 1)
%         
%         [Xout, ~] = getLargestCc(im, [], 3);
%         figure, imshow(Xout)
% end
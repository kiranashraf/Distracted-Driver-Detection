function [ a ] = getSkinRegion( RGB )
%GETSKINREGION Summary of this function goes here
%   Detailed explanation goes here
a = RGB;
[r c p] = size(a);
 HSV=rgb2hsv(a); % change the rgb to hsb color space
h =HSV(:,:,1); s =HSV(:,:,2); v =HSV(:,:,3); d=zeros(r,c);
 for i=1:r;
    for j=1:c;
        if ((h(i,j)<.25)&&((s(i,j)<.68)&& (s(i,j)>0.106)));
            d(i,j)=1;
            O=i-100;
           K=j-640;
         end
    end
 end
   for i=1:r;
        for j=1:c;
            F=d(i,j);
            if F~=1;
                a(i,j,1)=0;
                  a(i,j,2)=0;
                  a(i,j,3)=0;
            end
        end
   end
figure, imshow(a)
BW = im2bw(a, 0.2);
figure, imshow(BW)
end


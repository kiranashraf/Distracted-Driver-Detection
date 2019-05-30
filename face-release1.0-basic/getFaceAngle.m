function [ impos ] = getFaceAngle(boxes, posemap )
impos = [];
for b = boxes,
    %fprintf('impos %s',num2str(posemap(b.c)));
    impos = posemap(b.c);
    
end
if(isempty(impos))
    impos = inf;

end


function [ imposC8 ] = getFaceRotation( )
%GETFACEROTATION Summary of this function goes here
close all
P = addpath('../train/c9');
addpath('models');
%P = addpath('../MobInHandTest')
%ims = dir('../neg_nonface/*.jpg');
ims = dir('../train/c9/*.jpg');
addpath('face-release1.0-basic');

%compile;
%load and visualize model
%Pre-trained model with 146 parts. Works best for faces larger than 80*80
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

imposC8= ones(1,length(ims));
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    I = imread([ims(i).name]);
    im = getCroppedFace(I);
    %im = imresize(im,0.9);
    ang = faceOrientation(im,model,posemap);
    if(isempty(ang) == 0)
        imposC8(i) = str2double(ang);
    else
        imposC8(i) = double(inf);
    end
end

end


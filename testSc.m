P = addpath('../minTestImg/TestSet/');
ims = dir('../minTestImg/TestSet/*.jpg');
addpath('models');
[ model,posemap ] = init();

% read data from CSV file to write
classAcList = cell(length(ims),2);
acc = 0;
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    im = imread([ims(i).name]);
    classAcList(i,1) = {ims(i).name};
    for j = 0:7
        if(j == 1 || j==3)
            if(exist(strcat('C:\matlabWorkspace\myTest\C1C3\',ims(i).name), 'file') == 2)
                classAcList(i,2) = {'C1C3'};
            end
        elseif(j == 2 || j==4)
            if(exist(strcat('C:\matlabWorkspace\myTest\C2C4\',ims(i).name), 'file') == 2)
                classAcList(i,2) = {'C2C4'};
            end
        elseif(j == 0 || j== 7 || j==5)
            if(exist(strcat('C:\matlabWorkspace\myTest\C',num2str(j),'\',ims(i).name), 'file') == 2)
                classAcList(i,2) = {strcat('C',num2str(j))};
            end
        end
        if(exist(strcat('C:\matlabWorkspace\minTestImg\Distracted','\',ims(i).name), 'file') == 2)
            classAcList(i,3) = {'Y'};
        else
            classAcList(i,3) = {'N'};
        end
    end
    save('AcList.mat','classAcList');
end
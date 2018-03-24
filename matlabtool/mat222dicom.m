clear all;
close all;
clc;
rawdata = load("CHAI11_T1GdData_new.mat");
data = rawdata.savingData.registeredGroupSlices;
path = '../T1/T1Image/CHAI11-NEW/';
k = 0;
for i=289:290
    data1 = data{i, 4};
    [heigh, width] = size(data1);
    n = 3
    imshow(data1, []);
   for i =1:n
       positions = []
       
       drawposition = imrect
       position = getPosition(drawposition)
       positions = [positions ,position]
        %drawposition = imrect
        %position1 = getPosition(drawposition]
    end
    
    
    %xmin = position(1,1);
    %ymin = position(1,2);
    %xmax = position(1,3)+position(1,1);
    %ymax = position(1,4)+ position(1,2);
    
   
    k = k+1;
    %dicomwrite(data1,[path, num2str(k, '%06d'), '.dcm']);
end

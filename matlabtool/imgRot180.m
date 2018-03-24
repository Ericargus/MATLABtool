clear all;
close all;
clc;
data = load('DCUS26_T1GdData_new.mat');
j = 3000;
path = '/home/zxyu/T1/';
for i =140:160
    data1 = data.savingData.registeredGroupSlices{i, 4};
    %data2 = rot90(data1, 2);
    j = j+1;
    imshow(data1,[]);
    data2 = mat2gray(data1);
    imwrite(data2,[path,num2str(j,'%06d'), '.jpg']);
end
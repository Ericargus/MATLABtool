clear all;
close all;
clc;
k = 0.002;
data = load("CHAI11_T1GdData_new.mat");
dataA= data.savingData.registeredGroupSlices;
Path = '/home/zxyu/Data/VOCdevkit/VOC2007/Train/';
h = 800;
for i = 1:512
    dicomData = double(dataA{i, 4});
    h = h + 1;
    %maxPixel = max(max(imgData));
    %fakeData = dicomData;
    %fakeData(find(fakeData == 0)) = inf;
    %minPixel = min(min(dicomData));
    maxPixel = max(max(dicomData));
    fakeData = dicomData;
    fakeData(fakeData == 0) = inf;
    minPixel = min(min(fakeData));
    sumPixel = sum(sum(dicomData));
    avgPixel = sumPixel/(maxPixel-minPixel);
    a = tabulate(dicomData(:));
    pixelValue = a(:,1);
    pixelValueNum = a(:,2);
    pixelNum = length(pixelValue);
    j = 0;l = 0;
    left = 0;right = 0;
    for i = 1:pixelNum
        l = l+1;
        if l == pixelNum
            break
        end
        if pixelValueNum(l)<(k*avgPixel) && pixelValueNum(l+1)>=(k*avgPixel)
            left = pixelValue(i);
            con = 1;
            while con
                j = j+1;
                if pixelNum ==j
                    break
                end
                if pixelValueNum(pixelNum+1-j)<(k*avgPixel) && ...
                    pixelValueNum(pixelNum-j)>=(k*avgPixel)
                right = pixelValue(pixelNum-j);
                con = 0;
                else
                    continue
                end
            end
            break
        else
            continue
        end
    end
    if (maxPixel-minPixel)<512 || right == 0 || left == 0
        right = maxPixel;
        left = minPixel;
    end
    windowWindth = right - left;
    %windowCenter = (right - left)/2;
    toOne = dicomData > right;
    toZero = dicomData < left;
    img = (dicomData - left)/(windowWindth);
    img(toOne) = 1; img(toZero) = 0;
    img = uint8(img.*255);
    %axes(handles.AfterTrans);
    imshow(img, []),title('AfterTransform');
    %pause(1)
    %nLinearTranData = ((imgData - minPixel)./(maxPixel - minPixel)).^(0.6);
    %imshow(nLinearTranData, []);
    %imwrite(img, [Path, num2str(h, '%06d'),'.jpg']);
end
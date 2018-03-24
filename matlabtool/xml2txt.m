clear all;
close all;
clc;
xmlfile=dir('Annotations');
numOfxml=length(xmlfile)-2;
trainval=sort(randperm(numOfxml,floor(numOfxml*0.85)));
test=sort(setdiff(1:numOfxml,trainval));
trainvalsize=length(trainval);
train=sort(trainval(randperm(trainvalsize,floor(trainvalsize*0.8))));
val=sort(setdiff(trainval,train));
ftrainval=fopen(['trainval.txt'],'w');
ftest=fopen(['test.txt'],'w');
ftrain=fopen(['train.txt'],'w');
fval=fopen(['val.txt'],'w');
for i=1:numOfxml
    if ismember(i,trainval)
        fprintf(ftrainval,'%s\n',xmlfile(i+2).name(1:end-4));
        if ismember(i,train)
            fprintf(ftrain,'%s\n',xmlfile(i+2).name(1:end-4));
        else
            fprintf(fval,'%s\n',xmlfile(i+2).name(1:end-4));
        end
    else
        fprintf(ftest,'%s\n',xmlfile(i+2).name(1:end-4));
    end
end
fclose(ftrainval);
fclose(ftrain);
fclose(fval);
fclose(ftest);
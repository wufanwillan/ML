function [ TData] = Preprocessing( Data )
%PREPROCESSING Summary of this function goes here
%   input
%   TrainData:N1*D
%   TestData:N2*D

%   output:
%   TrainData:N1*D
%   TestData:N2*D

%   To map each data column into [-1,1]
[rTD,cTD]=size(Data);
TData=zeros(rTD,cTD);
for i=1:cTD
%     [T,PS]=mapminmax(zscore(Data(:,i)'));
    [T,PS]=mapminmax((Data(:,i)'));
    TData(:,i)=T';
end


end


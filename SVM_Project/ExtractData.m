function [ Data,Label ] = ExtractData( data,label )
%EXTRACTDATA Summary of this function goes here

%   input: 
%   None

%   output:
%   TrainData(N1*D)
%   TrainLabel(N1)
%   TestData(N2*D)
%   TestLabel(N2)
Label=label;
[rTL,cTL]=size(Label);
Data=data';
[rTD,cTD]=size(Data);
if rTL~= rTD
    Warning='Warning: Please transform the Data matrix'
end



end


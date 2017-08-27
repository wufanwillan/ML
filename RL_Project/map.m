function [ output_args ] = map( input_args )
%MAP Summary of this function goes here
%   Detailed explanation goes here
load('pathlist')
path=zeros(10,10);
[r,c]=size(pathlist);
for i=1:r
    col=ceil(pathlist(i,1)/10);
    row=mod(pathlist(i,1),10);
    path(10-row,col)=pathlist(i,2);
end
[x,y]=find(path==-1);
plot(x,y,'^'),hold on
[x,y]=find(path==10);
plot(x,y,'>'),hold on
[x,y]=find(path==1);
plot(x,y,'v'),hold on
[x,y]=find(path==-10);
plot(x,y,'<'),hold on

end


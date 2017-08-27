function [ output_args ] = drawmap( input_args )
%DRAWMAP Summary of this function goes here
%   Detailed explanation goes here
load('subQmatrix1')
initialstate=1;
finalstate=100;
actionlist=[-1,10,1,-10];
actionseq=1:4;
currentstate=initialstate;
path=zeros(10,10);
while(currentstate~=100)
    maxaction=max(Qmatrix(currentstate,:));
    [~,maxindex]=find(Qmatrix==maxaction);
    indexnum=length(maxindex);
    selectnum=ceil(indexnum*rand(1,1));
    action=actionseq(maxindex(selectnum));
    row=mod(currentstate,10);
    col=ceil(currentstate/10);
    if row==0
        row=10;
    end
    if col==11
        break;
    end
    path(row,col)=action;
    currentstate=currentstate+actionlist(action);
end
[x,y]=find(path==1);
plot(x,y,'¡Ä'),hold on
[x,y]=find(path==2);
plot(x,y,'>'),hold on
[x,y]=find(path==3);
plot(x,y,'¡Å'),hold on
[x,y]=find(path==4);
plot(x,y,'<'),hold on
    

end


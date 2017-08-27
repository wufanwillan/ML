function [ qevalstates,rewardvalue ] = RL_drawdp( input_args )
%% Qmatrix for Q-learning
% load('Qmatrix')
%% Qlearn for dynamic programming
load('Qlearn')
load('task1.mat')
startstate=1;
endstate=100;
currentstate=startstate;
previousstate=startstate;
actionlist=[-1,10,1,-10];
pathlist=[0 0];
k=1;
rewardvalue=0;
qevalstates=[];
while(currentstate~=endstate)
    previousstate=currentstate;
    qevalstates(k)=currentstate;
    [maxq,maxindex]=max(Qmatrix(currentstate,:));
    action=maxindex;
    pathlist(k,:)=[currentstate action];
    currentstate=currentstate+actionlist(action);
    k=k+1;
    if k>30
        break;
    end
end
[r,c]=size(pathlist);
for i=1:r
    row=mod(pathlist(i,1),10);
    if row==0
        row=10;
    end
    col=ceil(pathlist(i,1)/10);
    path(11-row,col)=pathlist(i,2);
    rewardvalue=rewardvalue+reward(pathlist(i,1),pathlist(i,2));
end
[y,x]=find(path==1);
plot(x-0.5,y-0.5,'^'),hold on
[y,x]=find(path==2);
plot(x-0.5,y-0.5,'>'),hold on
[y,x]=find(path==3);
plot(x-0.5,y-0.5,'v'),hold on
[y,x]=find(path==4);
plot(x-0.5,y-0.5,'<'),hold on
grid on
axis([0 10 0 10])
% title('¦Ã=0.5 ¦Å_k,¦Á_k=1/k')
% title('¦Ã=0.9 ¦Å_k,¦Á_k=100/(100+k)')
% title('¦Ã=0.9 ¦Å_k,¦Á_k=(1+log(k))/k')
% title('¦Ã=0.9 ¦Å_k,¦Á_k=(1+5log(k))/k')
end


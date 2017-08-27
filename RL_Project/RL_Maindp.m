function [ numtogoal,time ] = RL_Maindp( input_args )
%RL_MAIN Summary of this function goes here
%   Detailed explanation goes here
load('qevalreward.mat')
gamma=0.9;
numtogoal=zeros(1,10);
time=zeros(1,10);
k=1;
Qmatrix=zeros(100,4);
tic
while (k<3000)
    Qbase=Qmatrix;
    for i=1:100
        for j=1:4
            qreward=reward(i,j);
            if qreward==-1
                continue;
            else
                Qmatrix(i,j)=qreward+gamma*max(Qmatrix(i+actionlist(j),:));
            end
        end
    end
    Qnew=Qmatrix;
    diff=max(Qnew-Qbase);
    if diff<1e-4
        break;
    end
    k=k+1;
end
toc
save('Qlearn','Qmatrix');    
[ qevalstates,rewardvalue ] = RL_drawdp()
end



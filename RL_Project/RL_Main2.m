function [ numtogoal,time ] = RL_Main( input_args )
%RL_MAIN Summary of this function goes here
%   Detailed explanation goes here
load('qevalreward.mat')
initialstate=1;
finalstate=100;
actionlist=[-1,10,1,-10];
exitflagseq=zeros(1,3000);
% gamma=[0.5,0.9];
gamma=0.9;
numtogoal=zeros(1,10);
time=zeros(1,10);
kk=0;
pathlist=[0 0 0];
for n=1:10
    Qmatrix=zeros(100,4);
    exitflagseq=zeros(1,10);
    diffbase=Qmatrix;

    tic
    for k=1:3000
        
        currentstate=initialstate;
        seq=1;
        exitflag=0;
        N=1;

        while (1)
            actseq=1:4;
           
%             alpha=1/seq;
            alpha=100/(100+seq);
%                 alpha=(1+log(seq))/seq;
%                 alpha=(1+5*log(seq))/seq;
            epsilon=alpha;
            ExploitationPro=1-epsilon;
            ExplorationPro=epsilon;
            Qaction=Qmatrix(currentstate,:);
            selectaction=rand(1,1);
            if selectaction<ExploitationPro
                Exploitationaction=Qaction;
                [~,col]=find(reward(currentstate,:)==-1);
                removecol=col;
                Exploitationaction(removecol)=[];
                actseq(removecol)=[];    
                maxnum=max(Exploitationaction);
                maxindex=find(Exploitationaction==maxnum);
                remainact=randperm(length(maxindex));
                rndact=remainact(1);
                selectact=actseq(maxindex(rndact));
                action=selectact;
            else
                Explorationaction=Qaction;
                maxnum=max(Explorationaction);
                maxindex=find(Explorationaction==maxnum);
                remainact=randperm(length(maxindex));
                rndact=remainact(1);                
                [~,col]=find(reward(currentstate,:)==-1);
                removecol=[maxindex(rndact),col];
                Explorationaction(removecol)=[];
                actseq(removecol)=[];     
                selectactpro=1/length(Explorationaction);
                selectactnum=rand(1,1);
                for i=1:length(Explorationaction)
                    if (((i-1)*selectactpro)<=selectactnum)&&(((i)*selectactpro)>=selectactnum)
                        selectact=actseq(i);
                        break;
                    end
                end
                action=selectact;
            end
            previousstate=currentstate;
            currentstate=currentstate+actionlist(action);
            pathlist(N,:)=[previousstate,actionlist(action),reward(previousstate,action)];
            N=N+1;
            Qmatrix(previousstate,action)=Qmatrix(previousstate,action)+alpha*(reward(previousstate,action)+gamma*max(Qmatrix(currentstate,:))-Qmatrix(previousstate,action));
            seq=seq+1;
            if alpha<0.005
                exitflag=-1;
                break;
            end
            if currentstate==finalstate
                exitflag=1;
                kk=kk+1;
                break;
            end
        end
%% Check converge. To assure we use 3000 trails, this part commented
%         diffcurrent=Qmatrix;
%         diff=max(max(diffcurrent-diffbase));
%         if diff<1e-4
%             break;
%         end
%         diffbase=diffcurrent;
        exitflagseq(k)=exitflag;
    end
    time(n)=toc
    [sa,~]=find(exitflagseq==1);
    sumnum=sum(sa);
    numtogoal(n)=sumnum;
    save('time','time')
    save('numtogoal','numtogoal')
    save('Qmatrix','Qmatrix')
end
[ qevalstates,rewardvalue ]=RL_drawq()
end


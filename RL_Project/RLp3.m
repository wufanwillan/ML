function [ numtogoal,time ] = RL_Main( input_args )
%RL_MAIN Summary of this function goes here
%   Detailed explanation goes here
load('task1.mat')
initialstate=1;
finalstate=100;
endstate=1/0.005;
% endstate=2;
actionlist=[-1,10,1,-10];

exitflagseq=zeros(1,3000);

% gamma=[0.5,0.9];
gamma=0.9;
% numtogoal=zeros(1,length(gamma));
numtogoal=zeros(1,10);
time=zeros(1,10);
for n=1:10
    Qmatrix=zeros(100,4);
    exitflagseq=zeros(1,10);
    tic
    for k=1:3000

        currentstate=initialstate;
        seq=1;
        Qmatrix=zeros(100,4);
        exitflag=0;
        while (1)
            actseq=1:4;

%             alpha=1/seq;
%                 alpha=100/(100+seq);
                alpha=(1+log(seq))/seq;
            %     alpha=(1+5*log(seq))/seq;

            epsilon=alpha;
            ExploitationPro=1-epsilon;
%             ExploitationPro=1;
            ExplorationPro=epsilon;
            Qaction=Qmatrix(currentstate,:);
            selectaction=rand(1,1);
            if selectaction<ExploitationPro
                Exploitationaction=Qaction;
                [~,col]=find(reward(currentstate,:)==-1);
                removecol=col;
                Exploitationaction(removecol)=[];
                actseq(removecol)=[];    
                [maxnum,~]=max(Exploitationaction);
                [~,maxindex]=find(Exploitationaction==maxnum);
                rndact=ceil(length(maxindex)*rand(1,1));
                selectact=actseq(maxindex(rndact));
                action=selectact;
            else
                Explorationaction=Qaction;
                [maxnum,~]=max(Explorationaction);
                [~,maxindex]=find(Explorationaction==maxnum);
                rndact=ceil(length(maxindex)*rand(1,1));                
                [~,col]=find(reward(currentstate,:)==-1);
                removecol=[maxindex(rndact),col];
                Explorationaction(removecol)=[];
                actseq(removecol)=[];     
                selectactpro=1/length(Explorationaction);
                selectactnum=rand(1,1);
                for i=1:length(Explorationaction)
                    if (((i-1)*selectactpro)<selectactnum)&&(((i)*selectactpro)>selectactnum)
                        selectact=actseq(i);
                        break;
                    end
                end
                action=selectact;
            end
            previousstate=currentstate;
            currentstate=currentstate+actionlist(action);

            Qmatrix(previousstate,action)=Qmatrix(previousstate,action)+alpha*(reward(previousstate,action)+gamma*max(Qmatrix(currentstate,:)-Qmatrix(previousstate,:)));
            seq=seq+1;
            if seq>endstate
                exitflag=-1;
                break;
            end
            if currentstate==finalstate
                exitflag=1;
                break;
            end
        end
        exitflagseq(k)=exitflag;
    end
    time(n)=toc
    [sa,~]=find(exitflagseq==1);
    sumnum=sum(sa);
    numtogoal(n)=sumnum;
    save('time3','time')
    save('numtogoal3','numtogoal')
    save('Qmatrix3','Qmatrix')
end
end


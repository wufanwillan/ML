function [valicationerr,erate] = test4(lambda)
%MAIN Summary of this function goes here
%   This is the main entry of task without parameters
AA=load('spamData.mat');
AA=struct2cell(AA);
delta=0.0001;
valicationerr=0;
% %%%%%%%%%%%%%train data part%%%%%%%%%%%%
% 
% Atrain=cell(5);
% [ra,ca]=size(AA{3});
% 
% %%%%%%%%%segmentation into 5 folds%%%%%%%
% 
% for i=1:5
%     start=ra/5*(i-1)+1;
%     send=ra/5*i;
%     Ap=AA{3};
%     Atrain{i}=Ap(start:send,:);
% end
% 
% %%%%%%%%%connect train folds%%%%%%%%%%%%
% 
% T=zeros(1,ca);
% TT=cell(5);
% for i=1:5
%     T=zeros(1,ca);
%     for j=1:5
%         if i~=j
%             T=[T;Atrain{j}];
%             %size(T)
%         end
%     end
%     TT{i}=T(2:end,:);
% end
% 
% %%%%%%%%%%%train calculate part%%%%%%%%%%%%
% 
% Anum=cell(5);
% [ra,ca]=size(AA{1});
% 
% %%%%%%%%%%degmentation%%%%%%%%%%%%
% 
% for i=1:5
%     start=ra/5*(i-1)+1;
%     send=ra/5*i;
%     Ap=AA{1};
%     Anum{i}=Ap(start:send,:);
% end
% 
% %%%%%%%%%%%%%connection%%%%%%%%%%%%%
% 
% TTnum=cell(5);
% for i=1:5
%     Tnum=zeros(1,ca);
%     for j=1:5
%         if i~=j
%             Tnum=[Tnum;Anum{j}];
%         end
%     end
%     TTnum{i}=Tnum(2:end,:);
% end
% 
% %%%%%%%%%%Valication by LOOCV method%%%%%%%%%%%%
% sumerror=0;
% for i=1:5
%     
%     xf=TT{i};%Transfer the data.mat to Matrix 3056*57
%     [r,c]=size(xf);
% 
%     Binf=zeros(r,c);
%     for jj=1:c
%         Binf(:,jj)=zscore(xf(:,jj));
%     end
%     xc=TTnum{i};
%     %Binc=xc;%30
%     [r,c]=size(Binf);
%     [theta,J]=newton(Binf,xc,lambda);
% 
% % %%%%%%%%%%%%%classify%%%%%%%%%%
%     testp=Anum{i};
%     teste=Atrain{i};
%     [rt,ct]=size(teste);
%     for jj=1:c
%         teste(:,jj)=zscore(teste(:,jj),1);
%     end
% 
%     testre=zeros(rt,1);
% % t=ones(1,)
%     teste=[ones(rt,1) teste];
%     for ii=1:rt
%     p=sigmoid(teste(ii,:)*theta);
%         if p>0.5
%             testre(ii)=1;
%         else
%             testre(ii)=0;
%         end
%     end
%     %%%%%%%%Calculate err%%%%%%%%%%%
%     result=xor(testp,testre);
%     resultsum=sum(result);
%     erate=resultsum/rt;
% 
%     sumerror=sumerror+erate;
% end
% avererr=sumerror/5;
% valicationerr=avererr;

%%%%%%%%%Final model%%%%%%%%%%%%
validationerr=0;
xf=AA{3};%Transfer the data.mat to Matrix 3056*57
[r,c]=size(AA{3});
% for i=1:r
%     for j=1:c
%         xf(i,j)=xf(i,j)
Binf=zeros(r,c);
for i=1:c
    Binf(:,i)=zscore(xf(:,i));
end
xc=AA{1};
%Binc=xc;%30
[r,c]=size(Binf);
theta=newton(Binf,xc,lambda);

% %%%%%%%%%%%%test%%%%%%%%%%%
% 
% %%%%%%%%%%%%%classify%%%%%%%%%%
testp=AA{1};
teste=AA{3};
[rt,ct]=size(teste);
for i=1:ct
    teste(:,i)=zscore(teste(:,i));
end

testre=zeros(rt,1);
% t=ones(1,)
teste=[ones(rt,1) teste];
for i=1:rt

p=sigmoid(teste(i,:)*theta);
    if p>0.5
        testre(i)=1;
    else
        testre(i)=0;
    end
end
% size(testre)        

% size(testp)
% size(testre)
%%%%%%%%Calculate err%%%%%%%%%%%
result=xor(testp,testre);
resultsum=sum(result);
erate=resultsum/rt;
end



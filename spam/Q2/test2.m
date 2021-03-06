function [valicationerr,erate] = test2
%MAIN Summary of this function goes here
%   This is the main entry of task without parameters
AA=load('spamData.mat');
AA=struct2cell(AA);
delta=0.0001;
%%%%%%%%%%%%%%train data part%%%%%%%%%%%%

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
% 
% for iout=1:5
%     xf=TT{iout};
%     [r,c]=size(xf);
%     Binf=zeros(r,1);
%     %Binf=zeros(1,c);
%     for i=1:c
%         Binf=[Binf znormalize(xf(:,i))];
%     end
%     Binf=Binf(:,2:end);
%     %Binf=Binf(2:,:);
%     xc=TTnum{iout};
%     
%     V=cell(2);
%     V{1}=zeros(2,c);
%     V{2}=zeros(2,c);
%     bin=cell(2);
%     % a=a;
%     % b=b;
%     %%%%%%%%%%%%prior%%%%%%%%%%%%%%plug in
%     pr=xc;
%     prN=Calculaten(pr');
%     pi1pr=prN(1)/(prN(1)+prN(2));%prior of spam
%     pi0pr=1-pi1pr;%prior of not spam
%     %%%%%%%Class%%%%%%%%%%%%
%     %c=57;
%     bin1=zeros(1,c);
%     bin0=zeros(1,c);
%     for i=1:r
%         if xc(i)>0
%             bin1=[bin1;Binf(i,:)];
%         else
%             bin0=[bin0;Binf(i,:)];
%         end
%     end
%     bin1=bin1(2:end,:);%spam feature
%     bin0=bin0(2:end,:);%not spam
%     %size(bin1)
%     %size(bin0)
%     %%%%%%%%%%create ceita%%%%%%%%%%%%
%     %%%%%%%%%%calculate NC,NJ%%%%%%%%%
%     bin{1}=bin1;%spam
%     bin{2}=bin0;%not spam
%     for k=1:2
%         Bc=bin{k};
%         for i=1:c
%             [W x]=Calculateg(Bc(:,i));
%             Vv=V{k};
%             Vv(1,i)=W;
%             Vv(2,i)=x;%1/N of var
%             V{k}=Vv;
%             %size(Vv)
%         end
%     end
%    
%     ltestp=Anum{iout};
%     lteste=Atrain{iout};
%     
%     [rt,ct]=size(lteste);
%     for i=1:ct
%         lteste(:,i)=znormalize(lteste(:,i));
%     end
%     p1=pi1pr;
%     p0=pi0pr;
%     p=1;
%     Vv1=V{1};
%     Vv2=V{2};
%     testre=zeros(rt,1);
%     for i=1:rt
%         for j=1:ct
%                 p1=1/sqrt(Vv1(2,j)+delta)*exp(-(Vv1(1,j)-lteste(i,j)).^2/2/(Vv1(2,j)+delta))+delta;
%                 p0=1/sqrt(Vv2(2,j)+delta)*exp(-(Vv2(1,j)-lteste(i,j)).^2/2/(Vv2(2,j)+delta))+delta;
%                 p=p*p1/p0;
%         end
%         p
%         p=p*pi1pr/pi0pr;
%         if p>1
%             testre(i)=1;
%         elseif p==1
%             testre(i)=1;
%         else
%             testre(i)=0;
%         end
%     end
%        
% 
%     %testre
% 
%     result=xor(ltestp',testre');
%     resultsum=sum(result);
%     erate=resultsum/rt
%     sumerror=sumerror+erate;
% end
% avererr=sumerror/5;
% valicationerr=avererr

%%%%%%%%%Final model%%%%%%%%%%%%

xf=AA{3};%Transfer the data.mat to Matrix 3056*57
[r,c]=size(AA{3});
% for i=1:r
%     for j=1:c
%         xf(i,j)=xf(i,j)
Binf=zeros(r,c);
for i=1:c
    Binf(:,i)=zscore(xf(:,i),1);
end
xc=AA{1};
%Binc=xc;%30
[r,c]=size(Binf);
V=cell(2);
V{1}=cell(2);
V{2}=cell(2);
bin=cell(2);
% a=a;
% b=b;
%%%%%%%%%%%%prior%%%%%%%%%%%%%%plug in
pr=xc;
prN=Calculaten(pr');
pi1pr=prN(1)/(prN(1)+prN(2));%prior of spam
pi0pr=1-pi1pr;%prior of not spam
%%%%%%%Class%%%%%%%%%%%%
bin1=zeros(1,c);
bin0=zeros(1,c);
for i=1:r
    if xc(i,1)>0
        bin1=[bin1;Binf(i,:)];
    else
        bin0=[bin0;Binf(i,:)];
    end
end
bin1=bin1(2:end,:);%spam feature
bin0=bin0(2:end,:);%not spam

%%%%%%%%%%create ceita%%%%%%%%%%%%
%%%%%%%%%%calculate NC,NJ%%%%%%%%%

bin{1}=bin1;%spam
bin{2}=bin0;%not spam
for k=1:2
    Bc=bin{k};
    size(Bc);
    for i=1:c
        [W x]=Calculateg(Bc);
        Vv=V{k};
        Vv{1}=W;
        Vv{2}=x;
        V{k}=Vv;
    end
    
end
    
%%%%%%%%%%%%test%%%%%%%%%%%

%%%%%%%%%%%%%classify%%%%%%%%%%
testp=AA{2};
teste=AA{4};
[rt,ct]=size(teste);
for i=1:ct
    teste(:,i)=zscore(teste(:,i),1);
end
p1=pi1pr;
p0=pi0pr;
p=1;
Vv1=V{1};
Vv2=V{2};
lp=0;
me1=zeros(rt,ct);
me2=zeros(rt,ct);
cov1=zeros(ct,ct);
cov2=zeros(ct,ct);
% Vv1(1,1)-teste(1,1)
% Vv1(2,1)
% (-(Vv1(1,1)-teste(1,1)).^2/2/(Vv1(2,1)))
% exp(-(Vv1(1,1)-teste(1,1)).^2/2/(Vv1(2,1)))
% 1/(Vv1(2,1))*exp(-(Vv1(1,1)-teste(1,1)).^2/2/(Vv1(2,1).^2))
%     for i=1:rt
%         for j=1:ct
% %             p1=p1+log(1/sqrt(Vv1(2,j)))+(-(Vv1(1,j)-teste(i,j)).^2/2/(Vv1(2,j)));
% %             p0=p0+log(1/sqrt(Vv2(2,j)))+(-(Vv2(1,j)-teste(i,j)).^2/2/(Vv2(2,j)));
% %             %if Vv1()
%             me1(i,j)=teste(i,j)-Vv1(1,j);
%             
%             me2(i,j)=teste(i,j)-Vv1(2,j);
% %                 p1=1/sqrt(Vv1(2,j))*exp(-(Vv1(1,j)-teste(i,j)).^2/2/(Vv1(2,j)));%+delta;
% %                 p0=1/sqrt(Vv2(2,j))*exp(-(Vv2(1,j)-teste(i,j)).^2/2/(Vv2(2,j)));%+delta;
% %                 p1=1/(Vv1(2,j))*exp(-(Vv1(1,j)-teste(i,j)).^2/2/(Vv1(2,j).^2))%+delta;
% %                 p0=1/(Vv2(2,j))*exp(-(Vv2(1,j)-teste(i,j)).^2/2/(Vv2(2,j).^2));%+delta;
%                 %p=p*p1/p0;
%                 %lp=lp+lp1-lp0;
%         end

        %lp=lp+log(pi1pr)-log(pi0pr);
%         p1=p1+og(pi1pr);
%         p0=p0+pi0pr;
        %p=pi1pr/pi0pr*p;
%         p1=(p1)*pi1pr;
%         p0=(p0)*pi0pr;
% size(inv(Vv1{2}))
% size((teste(1,:)-Vv1{1}))
% size((teste(1,:)-Vv1{1})*inv(Vv1{2})*(teste(1,:)-Vv1{1})')
testre=zeros(rt,1);
for i=1:rt
    p1=log(pi1pr/(sqrt(det(Vv1{2}))))+(-0.5*(teste(i,:)-Vv1{1})*inv(Vv1{2})*(teste(i,:)-Vv1{1})');
    p0=log(pi0pr/(sqrt(det(Vv2{2}))))+(-0.5*(teste(i,:)-Vv2{1})*inv(Vv2{2})*(teste(i,:)-Vv2{1})');
%     p11=p1/(p1+p0);
%     p00=1-p11;
    if p1>=(p0+log(9))
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
erate=resultsum/rt
end



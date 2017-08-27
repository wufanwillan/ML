function [valicationerr,eratefi] = Main(a,b)
%MAIN Summary of this function goes here
%   This is the main entry of task without parameters
AA=load('spamData.mat');
AA=struct2cell(AA);
delta=0.0001;
%%%%%%%%%%%%%%train data part%%%%%%%%%%%%

Atrain=cell(5);
[ra,ca]=size(AA{3});

% r=randperm(size(AA{3},1));
% temp=AA{3};
% temp=temp(r,:);
% AA{3}=temp;
% r=randperm(size(AA{3},1));
% temp=AA{3};
% temp=temp(r,:);
% AA{3}=temp;
% r=randperm(size(AA{3},1));
% temp=AA{3};
% temp=temp(r,:);
% AA{3}=temp;
%%%%%%%%segmentation into 5 folds%%%%%%%

for i=1:5
    start=ra/5*(i-1)+1;
    send=ra/5*i;
    Ap=AA{3};
    Atrain{i}=Ap(start:send,:);
end

%%%%%%%%%connect train folds%%%%%%%%%%%%

T=zeros(1,ca);
TT=cell(5);
for i=1:5
    T=zeros(1,ca);
    for j=1:5
        if i~=j
            T=[T;Atrain{j}];
            %size(T)
        end
    end
    TT{i}=T(2:end,:);
end

%%%%%%%%%%%train calculate part%%%%%%%%%%%%

Anum=cell(5);
[ra,ca]=size(AA{1});

%%%%%%%%%%degmentation%%%%%%%%%%%%

for i=1:5
    start=ra/5*(i-1)+1;
    send=ra/5*i;
    Ap=AA{1};
    Anum{i}=Ap(start:send,:);
end

%%%%%%%%%%%%%connection%%%%%%%%%%%%%

TTnum=cell(5);
for i=1:5
    Tnum=zeros(1,ca);
    for j=1:5
        if i~=j
            Tnum=[Tnum;Anum{j}];
        end
    end
    TTnum{i}=Tnum(2:end,:);
end

%%%%%%%%%%Valication by LOOCV method%%%%%%%%%%%%
sumerror=0;
for iout=1:5
    xf=TT{iout};
    Binf=Binarize(xf);
    xc=TTnum{iout};
    [r,c]=size(Binf);
    V=cell(2);
    V{1}=zeros(2,c);
    V{2}=zeros(2,c);
    bin=cell(2);
    % a=a;
    % b=b;
    %%%%%%%%%%%%prior%%%%%%%%%%%%%%plug in
    pr=xc;
    prN=Calculaten(pr');
    pi1pr=prN(1)/(prN(1)+prN(2));%prior of spam
    pi0pr=1-pi1pr;%prior of not spam
    %%%%%%%Class%%%%%%%%%%%%
    %c=57;
    bin1=zeros(1,c);
    bin0=zeros(1,c);
    for i=1:r
        if xc(i)>0
            bin1=[bin1;xf(i,:)];
        else
            bin0=[bin0;xf(i,:)];
        end
    end
    bin1=bin1(2:end,:);%spam feature
    bin0=bin0(2:end,:);%not spam
    %size(bin1)
    %size(bin0)
    %%%%%%%%%%create ceita%%%%%%%%%%%%
    %%%%%%%%%%calculate NC,NJ%%%%%%%%%
    bin{1}=bin1;%spam
    bin{2}=bin0;%not spam
    for k=1:2
        Bc=bin{k};
        for i=1:c
            W=Calculaten(Bc(:,i));
            Vv=V{k};
            Vv(1,i)=W(1,1)+1;%Laplace smooth
            Vv(2,i)=W(2,1)+1;
            V{k}=Vv;
        end
    end
    %Vk=[2,i]
        %p0L=zeros(1001,c);
        p1Lm=zeros(2,c);
        p0Lm=zeros(2,c);
    for k=1:2
        Vr=V{k};
        for j=1:c
%             p0Lo=pdf('Beta',0:0.001:1,a+Vr(1,j),b+Vr(2,j));
%             plot(0:0.001:1,p0Lo),hold on;
%             p0L1=pdf('Beta',0:0.001:1,a+99+Vr(1,j),b+99+Vr(2,j));
%             plot(0:0.001:1,p0L1),hold on;
            %p0L(:,i)=p0Lo;
            %Vr(1,j)
            p1Lm(k,j)=(a+Vr(1,j))/(a+Vr(1,j)+b+Vr(2,j));
            p0Lm(k,j)=(b+Vr(2,j))/(a+Vr(1,j)+b+Vr(2,j));
        end
    end
    %sumerror=0;
    p1=pi1pr;
    p0=pi0pr;
    ltestp=Anum{iout};
    lteste=Atrain{iout};
    lteste=Binarize(lteste);
   
    [rt,ct]=size(lteste);
%     prc=zeros(2,ct);
%     for f=1:ct
%         prc(:,f)=Calculaten(lteste(:,f));
%     end
        
    testre=zeros(rt,1);
    for i=1:rt
        for j=1:ct
            if lteste(i,j)>0
                %p1=(p1Lm(1,j)+prc(1,j))/(p1Lm(1,j)+prc(1,j)+prc(2,j)+p0Lm(1,j));
                %p0=(p0Lm(1,j)+prc(1,j))/(p1Lm(1,j)+prc(1,j)+prc(2,j)+p0Lm(1,j));
                p1=p1Lm(1,j);
                p0=p1Lm(2,j);
            else
                p1=p0Lm(1,j);
                p0=p0Lm(2,j);
                
                %p1=(p0Lm(1,j)+prc(2,j))/(p1Lm(1,j)+prc(1,j)+prc(2,j)+p0Lm(1,j));
                %p0=(p0Lm(1,j)+prc(2,j))/(p1Lm(1,j)+prc(1,j)+prc(2,j)+p0Lm(1,j));
            end
            %testre(i,1)=testre(i,1)*(p1)/(p0);
            testre(i,1)=testre(i,1)+log(p1+eps)-log(p0+eps);
        end
        testre(i,1)=testre(i,1)+log(pi1pr+eps)-log(pi0pr+eps);
        if testre(i,1)>0
            testre(i,1)=1;
        elseif testre(i,1)
            testre(i,1)=0;
        else
            testre(i,1)=1;
        end
    end
    %testre

    result=xor(ltestp',testre');
    resultsum=sum(result);
    erate=resultsum/rt;
    sumerror=sumerror+erate;
end
avererr=sumerror/5;
valicationerr=avererr;

%%%%%%%%%Final model%%%%%%%%%%%%
erate=0;
xf=AA{3};%Transfer the data.mat to Matrix 3056*57
Binf=Binarize(xf);
xc=AA{1};
%Binc=xc;%30
[r,c]=size(Binf);
V=cell(2);
V{1}=zeros(2,c);
V{2}=zeros(2,c);
bin=cell(2);
% a=a;
% b=b;
%%%%%%%%%%%%prior%%%%%%%%%%%%%%plug in
pr=xc;
prN=Calculaten(pr');
pi1pr=(prN(1)+a)/(prN(1)+prN(2)+a+b);%prior of spam
pi0pr=1-pi1pr;%prior of not spam
%%%%%%%Class%%%%%%%%%%%%
bin1=zeros(1,c);
bin0=zeros(1,c);
for i=1:r
    if xc(i,1)>0
        bin1=[bin1;xf(i,:)];
    else
        bin0=[bin0;xf(i,:)];
    end
end
bin1=bin1(2:end,:);%spam feature
bin0=bin0(2:end,:);%not spam
%size(bin1)
%size(bin0)
%%%%%%%%%%create ceita%%%%%%%%%%%%
%%%%%%%%%%calculate NC,NJ%%%%%%%%%
bin{1}=bin1;%spam
bin{2}=bin0;%not spam
for k=1:2
    Bc=bin{k};
    for i=1:c
        W=Calculaten(Bc(:,i));
        Vv=V{k};
        Vv(1,i)=W(1,1);
        Vv(2,i)=W(2,1);
        V{k}=Vv;
    end
end
%Vk=[2,i]
    p0L=zeros(1001,c);
    p1Lm=zeros(2,c);
    p0Lm=zeros(2,c);
for k=1:2
    Vr=V{k};
    for i=1:c
        %p0Lo=pdf('Beta',0:0.001:1,a+Vr(1,i),b+Vr(2,i));
        %p0L(:,i)=p0Lo;
        p1Lm(k,i)=(a+Vr(1,i))/(a+Vr(1,i)+b+Vr(2,i));
        p0Lm(k,i)=(b+Vr(2,i))/(a+Vr(1,i)+b+Vr(2,i));
    end
end

%%%%%%%%%%%%test%%%%%%%%%%%

%%%%%%%%%%%%%classify%%%%%%%%%%
testp=AA{2};
teste=AA{4};
teste=Binarize(teste);
[rt,ct]=size(teste);
p1=pi1pr;
p0=pi0pr;
testre=ones(rt,1);
    for i=1:rt
        for j=1:ct
            if teste(i,j)>0
                p1=p1Lm(1,j);
                p0=p1Lm(2,j);
            else
                p1=p0Lm(1,j);
                p0=p0Lm(2,j);
            end
            testre(i,1)=testre(i,1)+log(p1+eps)-log(p0+eps);
        end
        testre(i,1)=testre(i,1)+log(pi1pr)-log(pi0pr);
        if testre(i,1)>0
            testre(i,1)=1;
        elseif testre(i,1)<0
            testre(i,1)=0;
        else
            testre(i,1)=1;
        end
%         if p1>p0
%             testre(i,1)=1;
%         else
%             testre(i,1)=0;%0.5?
%         end
    end
%%%%%%%%Calculate err%%%%%%%%%%%
result=xor(testp',testre');
resultsum=sum(result);
eratefi=resultsum/rt;
end



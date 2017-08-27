function [ output_args ] = Main( input_args )
%MAIN Summary of this function goes here
%   Detailed explanation goes here
method=1;
%   method 1:linear hard margin
%   method 2:polynomial hard margin
%   method 3:polynomial soft margin
%   method 4:my SVM hardmargin
%   method 5:my SVM softmargin
load('train.mat')
%% Extract Data
[TrainDataOri,TrainLabel] = ExtractData(data,label);
load('test.mat')
[TestDataOri,TestLabel]=ExtractData(data,label);
%% PCA dimension reduction
acc=zeros(7,1);
[Coeff,Score,Latent] = princomp(TrainDataOri);
SumLatent=sum(Latent);
for i=1:length(Latent)
    if Latent(i)<10^-5
        Dimension=i;
        break;
    end
end
meandata=mean(TrainDataOri,1);
TrainData=bsxfun(@minus,TrainDataOri,meandata)*Coeff(:,1:Dimension);
TestData=bsxfun(@minus,TestDataOri,meandata)*Coeff(:,1:Dimension);
%% Preprocessing Data
[TrainData]=Preprocessing(TrainData);
[TestData]=Preprocessing(TestData);
%% Prepare size of data
[rTrD,cTrD]=size(TrainData);
[rTeD,cTeD]=size(TestData);
[rTrL,cTrL]=size(TrainLabel);
[rTeL,cTeL]=size(TestLabel);

%% SVM classifier

%% Kernel
[Kernelmat,C]=Kernel(TrainData,TrainData,method);
[~,~,dimension]=size(Kernelmat);
if C==10.^6
    name='Hard Margin Selected'
    Csoft=C;
elseif C==0
    name='soft Margin Selected'
    Csoft=[0.1 0.6 1.1 2.1];
elseif C==1
    name='soft Margin Selected'
    Csoft=0.1;
else
    name='soft Margin linear'
    Csoft=2.2;
    dimension=1;
%     Csoft=2.0:0.1:5.0;
end

%% Solve Inequation
for d=1:dimension
    Kernelout=Kernelmat(:,:,d);
    for k=1:length(Csoft)
        C=Csoft(k);
        Aeq=TrainLabel';
        beq=0;
        lb=zeros(rTrL,1);
        ub=C*ones(rTrL,1);
        f=-1*ones(rTrL,1);
        H=zeros(rTrD,rTrD);
        A=[];
        b=[];
        for i=1:rTrD
            for j=1:rTrD
                H(i,j)=TrainLabel(i,1)*TrainLabel(j,1)*Kernelout(i,j);
            end
        end
        x0=[];
        options=optimset('LargeScale','off','MaxIter',1000);
        alpha=quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,options);
        %% Generate Discriminant function      
        [ Index] = FindSupport( alpha,C );
        bias=0;
        for n=1:length(Index)
            N=n;
            SupportVector=TrainData(Index(N),:);
            wvector=alpha.*TrainLabel;
            w=wvector'*Kernelout(:,Index(N));
            bb=1/TrainLabel(Index(N))-w;
            bias=bias+bb;
        end
        bias=bias/(length(Index))
        weight=(alpha.*TrainLabel)'*TrainData;
        save('weight','weight')
        save('bias','bias')
    end
end
end

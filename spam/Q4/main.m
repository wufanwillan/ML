function main
%MAIN Summary of this function goes here
%   Detailed explanation goes here
A=load('spamData.mat');
A=struct2cell(A);
testz(A);
testlog(A);
testz(A);
testb(A);
testlogt(A);
testzt(A);
testbt(A);
% X=lognormalize(A{4});
% Xtrain=lognormalize(A{3});
% Ytrain=A{1};
% [r,c]=size(X);
% Y=zeros(1,r);
% errorrate=zeros(28,1);
% i=1;
% for k=1:10
%     Y=KNN(X',Xtrain',Ytrain',k);
%     Y=Y';
%     result=xor(Y,A{2});
%     errorrate(i)=sum(result)/r;
%     i=i+1;
% end
% for k=15:5:100
%     Y=KNN(X',Xtrain',Ytrain',k);
%     Y=Y';
%     result=xor(Y,A{2});
%     errorrate(i)=sum(result)/r;
%     i=i+1;
% end
% errorrate
% x1=1:10;
% x2=15:5:100;
% x=[x1 x2];
% plot(x,errorrate);

end


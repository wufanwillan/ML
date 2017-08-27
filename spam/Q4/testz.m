function b= testlog( A )
%TESTLOG Summary of this function goes here
%   Detailed explanation goes here
[r,c]=size(A);
    yt=A{4};
    xt=A{3};
    X=zscore(yt);
    size(X)
    Xtrain=zscore(xt);
Ytrain=A{1};
[r,c]=size(X);
Y=zeros(1,r);
errorrate=zeros(28,1);
i=1;
for k=1:10
    Y=KNN(X',Xtrain',Ytrain',k);
    Y=Y';
    result=xor(Y,A{2});
    errorrate(i)=sum(result)/r;
    i=i+1;
end
for k=15:5:100
    Y=KNN(X',Xtrain',Ytrain',k);
    Y=Y';
    result=xor(Y,A{2});
    errorrate(i)=sum(result)/r;
    i=i+1;
end
errorrate;
x1=1:10;
x2=15:5:100;
x=[x1 x2];
plot(x,errorrate,'g'),hold on;
b=zeros(3,1);
b(1)=errorrate(1)
b(2)=errorrate(10)
b(3)=errorrate(28)
end


function [ output_args ] = q323( input_args )

clear;
clc;
n=20;
x=[0 1;1 1];%COMPLEMENT INPUT
d=[1 0];%COMPLEMENT OUTPUT 
ww=[2*(rand-0.5);2*(rand-0.5)];%INITIAL WEIGHT
w=zeros(2,n-1);
w=[ww w];
www=zeros(2,1);%record sub-epoch weight
eta=1;%learning rate
%eta=0.1;
e=zeros(1,length(d));%error value
k=1;

for epoch=1:n
    for i=1:length(d)
        if w(:,epoch)'*x(i,:)'>0
            y=1;
        else
            y=0;
        end
        e(i)=d(i)-y;
        w(:,epoch)=w(:,epoch)+eta*e(i)*x(i,:)';%update weight
        www(:,k)=w(:,epoch);%record
        k=k+1;
    end
    if epoch<n
    w(:,epoch+1)=w(:,epoch);
    end
end
figure
plot([1:epoch],w(1,:),'r',[1:epoch],w(2,:),'g');
title('COMPLEMENT logic weight(eta=0.1)');
legend('weight1','bias');
xlabel('epoch');
ylabel('weight');

figure
plot([1:length(d)*epoch],www(1,:),'r',[1:length(d)*epoch],www(2,:),'g');
title('COMPLEMENT logic weight(eta=0.1)');
legend('weight1','bias');
xlabel('sub-epoch');
ylabel('weight');
end


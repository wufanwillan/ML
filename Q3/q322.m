function [ output_args ] = q322( input_args )
clear;
clc;
n=20;
x=[0 0 1;0 1 1;1 0 1;1 1 1];%OR INPUT
d=[0 1 1 1];%OR OUTPUT 
ww=[2*(rand-0.5);2*(rand-0.5);2*(rand-0.5)];%INITIAL WEIGHT
w=zeros(3,n-1);
w=[ww w];
www=zeros(3,1);%record sub-epoch weight
eta=1;%learning rate
%eta=0.1
e=zeros(1,4);%error value
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
plot([1:epoch],w(1,:),'r',[1:epoch],w(2,:),'g',[1:epoch],w(3,:),'b');
title('OR logic weight');
legend('weight1','weight2','bias');
xlabel('epoch');
ylabel('weight');

figure
plot([1:length(d)*epoch],www(1,:),'r',[1:length(d)*epoch],www(2,:),'g',[1:length(d)*epoch],www(3,:),'b');
title('OR logic weight(sub-epoch)');
legend('weight1','weight2','bias');
xlabel('sub-epoch');
ylabel('weight');
end


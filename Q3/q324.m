function [ output_args ] = q324( input_args )
%Q321 Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;
n=20;
x=[0 0 1;0 1 1;1 0 1;1 1 1];%NAND INPUT
d=[1 1 1 0];%NAND OUTPUT 
ww=[2*(rand-0.5);2*(rand-0.5);2*(rand-0.5)];%INITIAL WEIGHT
w=zeros(3,n-1);%
w=[ww w];
www=zeros(3,1);%record sub-epoch weight
eta=1;%learning rate
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
title('NAND logic weight(eta=0.1)');
legend('weight1','weight2','bias');
xlabel('epoch');
ylabel('weight');

figure
plot([1:length(d)*epoch],www(1,:),'r',[1:length(d)*epoch],www(2,:),'g',[1:length(d)*epoch],www(3,:),'b');
title('NAND logic weight(eta=0.1)');
legend('weight1','weight2','bias');
xlabel('sub-epoch');
ylabel('weight');
end


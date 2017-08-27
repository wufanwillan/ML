function [ output_args ] = q321( input_args )
%Q321 Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;
n=20;
x=[1 0 0;1 0 1;1 1 0;1 1 1];%AND INPUT
d=[0 1 1 0];%AND OUTPUT 
w(:,1)=[2*(rand-0.5);2*(rand-0.5);2*(rand-0.5)];
%ww=[0.5;0.2;0.3];
k=2;%INITIAL WEIGHT
eta=1;
for epoch=1:n
    for i=1:length(d)
        if w(:,k-1)'*x(i,:)'>0+eps
            y=1;
        else
            y=0;
        end
        e(i)=d(i)-y;
        w(:,k)=w(:,k-1)+eta*e(i)*x(i,:)';
        k=k+1;
    end
end
figure
plot([1:k-1],w(1,:),'r',[1:k-1],w(2,:),'g',[1:k-1],w(3,:),'b');
title('EXCLUSIVE OR logic weight');
legend('weight1','weight2','bias');
xlabel('iteration');
ylabel('weight');
end


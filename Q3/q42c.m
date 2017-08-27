function [ output_args ] = q321( input_args )
%Q321 Summary of this function goes here
%   Detailed explanation goes here
clear;
clc;
n=100;
x=[0,0.8,1.6,3,4.0,5.0;1,1,1,1,1,1]';%6 2
d=[0.5 1 4 5 6 9]';
ww=[2*(rand-0.5);2*(rand-0.5)];
% ww=[0.5;0.2;0.3];
w=zeros(2,n-1);%INITIAL WEIGHT
w=[ww w];
www=zeros(2,1);
k=1;

eta=0.01;
e=zeros(1,6);

for epoch=1:n
    for i=1:length(d)
        y=w(:,epoch)'*x(i,:)';
        e(i)=d(i)-y;
        w(:,epoch)=w(:,epoch)+eta*e(i)*x(i,:)';
        www(:,k)=w(:,epoch);
        k=k+1;
    end
    if epoch<n
    w(:,epoch+1)=w(:,epoch);
    end
end
figure
plot([1:epoch],w(1,:),'r',[1:epoch],w(2,:),'g');
title('LMS');
legend('weight1','bias');
xlabel('iteration');
ylabel('weight');

% figure
% plot([1:epoch*4],www(1,:),'r',[1:epoch*4],www(2,:),'g',[1:epoch*4],www(3,:),'b');
% title('EXCLUSIVE OR logic weight');
% legend('weight1','weight2','bias');
% xlabel('sub-iteration');
% ylabel('weight');
end


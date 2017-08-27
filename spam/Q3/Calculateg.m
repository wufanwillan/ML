function [a b]= Calculateg( vec )
%CALCULATEG Summary of this function goes here
%   Detailed explanation goes here
[N,c]=size(vec);
a=zeros(1,c);
b=zeros(c,c);
d=zeros(c,c);
temp=zeros(1,c);
% a=mean(vec);%gaussian mean
% b=var(vec)*(N-1)/N;%/N;%var
    for j=1:c
        a(1,j)=1/N*sum(vec(:,j));
    end
%     t=(vec(1,:)-temp)'
% size(t)
for i=1:N
    temp=a;      
    d=d+(vec(i,:)-temp)'*(vec(i,:)-temp);
end
d=d/N;
for i=1:c
    b(i,i)=d(i,i);
end
% cov(vec)
% t=var(vec(:,1))*(N-1)/N
% b=cov(vec);
%     for j=1:c
%         b(j,j)=var(vec(:,j))*(N-1)/N;
%     end
end


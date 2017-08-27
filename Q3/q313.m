function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-(0.159812416947460/0.337647321744385)*z+(0.0612187178835884/0.337647321744385);
zzz=-(1.13564328145044/1.15170857912613)*z+(0.892099762666786/1.15170857912613);
plot(z,zzz),hold on
plot(z,zz),hold on

plot(x(1,1),x(2,1),'b*')
plot(x(1,2:4),x(2,2:4),'r*'),hold on
title('OR logic')
axis([0,1.5,0,1.5])
legend('decision boundary(eta=1)','decision boundary(eta=0.1)','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


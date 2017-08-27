function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-2.70737397977747/1.58127033828386*z+3.50937336396472/1.58127033828386;
zzz=-0.207373979777471/0.0812703382838550*z+0.209373363964722/0.0812703382838550;


plot(z,zz),hold on
plot(z,zzz),hold on
plot(x(1,4),x(2,4),'b*')
plot(x(1,1:3),x(2,1:3),'r*'),hold on
title('NAND logic(eta=1 & eta=0.1)')
axis([0,1.5,0,1.5])
legend('decision boundaryeta=1','decision boundary(eta=0.1)','class 0','class 1')
%legend('decision boundaryeta=1','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


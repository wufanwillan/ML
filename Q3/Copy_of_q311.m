function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-0.716227322745569/0.156477434747450*z+0.831471050378134/0.156477434747450;
zzz=-0.183772677254431/0.143522565252550*z+0.268528949621866/0.143522565252550;
% zzzz=-0.716227322745569/0.156477434747450*z+0.831471050378134/0.156477434747450;
% plot(z,zzzz),hold on
plot(z,zz),hold on
plot(z,zzz),hold on
plot(x(1,1:3),x(2,1:3),'b*'),hold on
plot(x(1,4),x(2,4),'r*')

title('AND logic(on-line,eta=1 & eta=0.1)')
axis([0,1.5,0,1.5])
legend('decision boundary(eta=1)','decision boundary(eta=0.1)','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


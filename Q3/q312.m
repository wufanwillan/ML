function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
z=0:0.01:1;
x=0;
y=0.3938;
yy=0.4759;
t=1;
zz=0*z;
plot(z,zz),hold on

plot(y,x,'o'),hold on
plot(yy,x,'o'),hold on
plot(t,x,'b*'),hold on
plot(x,x,'r*'),hold on

title('COMPLEMENT logic(eta=1 & eta=0.1)')
axis([0,1.5,0,1.5])
%legend('points line','decision boundary(eta=1)','class 0','class 1')
legend('points line','decision boundary(eta=1)','decision boundary(eta=0.1)','class 0','class 1')
xlabel('x1')
%ylabel('x2')
end


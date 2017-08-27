function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-(1.95929142520544/1.54721552996380)*z+2.86137555717132/1.54721552996380;
plot(z,zz),hold on

plot(x(1,4),x(2,4),'b*')
plot(x(1,1:3),x(2,1:3),'r*'),hold on
title('NAND logic(off-line)')
axis([0,1.5,0,1.5])
legend('decision boundary','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


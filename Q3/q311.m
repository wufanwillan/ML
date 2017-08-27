function [ output_args ] = q3( input_args )
%Q3 Summary of this function goes here
%   Detailed explanation goes here
x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-(0.223811939491137/0.2512670593056530)*z+0.444904884540731/0.251267059305653;
zzz=-(1.95929142520544/1.54721552996380)*z+2.86137555717132/1.54721552996380;
plot(z,zzz),hold on
plot(z,zz),hold on
plot(x(1,1:3),x(2,1:3),'b*'),hold on
plot(x(1,4),x(2,4),'r*')

title('AND logic(off-line)')
axis([0,1.5,0,1.5])
legend('decision boundary(eta=1)','decision boundary(eta=0.1)','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


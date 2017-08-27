function [ output_args ] = q41( input_args )
%Q41 Summary of this function goes here
%   Detailed explanation goes here
%x 6*2 weight 1*2 d 6*1 
x=[0,0.8,1.6,3,4.0,5.0;1,1,1,1,1,1]';%6 2
d=[0.5 1 4 5 6 9]';%6 1
w=inv(x'*x)*x'*d;
z=0:0.1:6;
zz=2.61155104786518*z-0.707219596774477;
zzz=1.5921*z+0.5072;
plot(x(:,1),d,'*');hold on
plot(z,zz,'c')
plot(z,zzz)
title('Compare between LLS and LMS')
xlabel('x')
ylabel('d')
legend('data points','LMS regression line(eta=0.1)','LMS regression line(eta=0.01)')

end


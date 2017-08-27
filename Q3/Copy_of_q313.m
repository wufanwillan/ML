function [ output_args ] = q3( input_args )

x=[0 1 0 1;0 0 1 1];
y=[0 0 0 1];
z=0:0.01:1.5;
zz=-1.07142335714838/0.698258611737554*z+0.132013504484899/0.698258611737554;
%zzz=-0.0714233571483789/0.698258611737554*z+0.0320135044848989/0.698258611737554;

plot(z,zz),hold on
%plot(z,zzz),hold on
plot(x(1,1),x(2,1),'b*')
plot(x(1,2:4),x(2,2:4),'r*'),hold on
title('OR logic(eta=1)')
axis([0,1.5,0,1.5])
legend('decision boundary(eta=1)','class 0','class 1')
% legend('decision boundary(eta=1)','decision boundary(eta=0.1)','class 0','class 1')
xlabel('x1')
ylabel('x2')
end


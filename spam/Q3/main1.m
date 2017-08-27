function main1
%MAIN1 Summary of this function goes here
%   Detailed explanation goes here
erate=0;
x1=1:10;
x2=15:5:100;
x=[x1 x2];
[~,c]=size(x);
ve1=zeros(1,c);
er1=zeros(1,c);
for i=1:1:10
    [ve1(i),er1(i)]=test1(i);
end
for i=11:28
    [ve1(i),er1(i)]=test1(10+(i-10)*5);
end
% figure,plot(x,ve1,'g--'),hold on;
% plot(x,er1,'y'),hold off;
% title('Logistic Regression validation and testing(Log)');
% legend('Log-validation','Log-testing');
ve2=zeros(1,c);
er2=zeros(1,c);
for i=1:1:10
    [ve2(i),er2(i)]=test2(i);
end
for i=11:28
    [ve2(i),er2(i)]=test3(10+(i-10)*5);
end
ve3=zeros(1,c);
er3=zeros(1,c);
for i=1:1:10
    [ve3(i),er3(i)]=test3(i);
end
for i=11:28
    [ve3(i),er3(i)]=test4(10+(i-10)*5);
end
%plot(x,ve2,'r--'),hold on;
%plot(x,ve3,'b--'),hold on;

figure,plot(x,er2,'r'),hold on;
plot(x,er3,'b'),hold on;
plot(x,er1,'y');
title('Logistic Regression of Three Methods');
%legend('Log-validation','Beta-validation','B-validation','Log-test','Z-test','B-test');
legend('Beta-test','Z-test','Log-test');
axis([0 100 0 1]);
er1(1)
er1(10)
er1(28)
er2(1)
er2(10)
er2(28)
er3(1)
er3(10)
er3(28)
end
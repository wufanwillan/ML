function main1
%MAIN1 Summary of this function goes here
%   Detailed explanation goes here
erate=0;
valicationerr=0;
terror=0;
c=[1 10 100];
for i=1:3
    b=c(i);
    a=c(i);
    [ar1,ar2]=Main(a,b);
    ar3=Main11(a,b);
    terror=[terror ar3];
    erate=[erate ar2];
    valicationerr=[valicationerr ar1];
end
a=1:0.5:100;
terror=terror(2:end);
% size(terror)
% size(a)
erate=erate(2:end);

%size(erate)
valicationerr=valicationerr(2:end);
%size(valicationerr)
plot(a,terror,'g'),hold on;
plot(a,erate,'r'),hold on;
plot(a,valicationerr,'b');
hold off;
%axis([0 100]);
end
function [ output_args ] = plotacc( input_args )
%PLOTACC Summary of this function goes here
%   Detailed explanation goes here
load('TestAccuracym.mat')
load('TrainAccuracym.mat')
te=TestAccuracy;
tr=TrainAccuracy;
x=.2:0.01:.3;
plot(x,tr,'--'),hold on
plot(x,te),hold on
axis([0.2,.3,.9,1])
legend('Train Accuracy','Test Accuracy')
xlabel('C for soft margin')
ylabel('Accuracy')
title('Soft Margin Linear SVM accuracy')
end


function [ Sa] = FindSupport( alpha,C )
%FINDSUPPORT Summary of this function goes here
%   input:
%   alpha:Inequation Lagrange Coefficient
%   C:Soft Margin parameter

%   To find support vector
threshold=10.^(-6);
[Sa,Index]=find((alpha>threshold)&(alpha<C));
[Sa0,Index0]=find(alpha<threshold);
end


function NL = sigmoid( x )
%NLL Summary of this function goes here
%   Detailed explanation goes here
[r c]=size(x);
NL=zeros(r,c);
for i=1:c
    NL(1,i)=1/(1+exp(-x(1,i)));
end


end


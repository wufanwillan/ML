function NL = NLL( vecx,vecy,lamda,omega )
%NLL Summary of this function goes here
%   Detailed explanation goes here
NLL=0.5*lamda*omega*omega';
NLL=NLL+(-sum(yi*log(1/1+exp-(omega*x'))+(1-yi)*(1-log(1/1+exp-(omega*x')))));

end


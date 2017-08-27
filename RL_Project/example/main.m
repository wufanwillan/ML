global ITERMAX NA NS SMALL TPM TRM LAMBDA

global1 % global parameters initialized

stat=struct('Q',zeros(NS,NA));

stat=qvid(stat,0.01);

policy=pol_finder(stat);


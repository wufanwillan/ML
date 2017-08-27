function stat=qvid(stat,epsilon)

global ITERMAX NA NS SMALL TPM TRM LAMBDA

% Determine termination factor 

epsilon=epsilon*(1-LAMBDA)*0.5/LAMBDA

% Initialize some values 

qvalue_old=zeros(NS,NA);


iter=0;

done=0;

while done==0

% main loop of value iteration 

	% Keeping a copy of the old Q factors 
        qvalue_old=stat.Q;

        % Q-factor Update 

	for state=1:NS
	% Value updated state by state 

	   for action=1:NA
	   % Update for each action  
	   sum=0;

                 for next_state=1:NS
                 qmax=max(qvalue_old(next_state,1),qvalue_old(next_state,2));
                 sum=sum+(TPM(state,next_state,action)*(TRM(state,next_state,action)+(LAMBDA*qmax)));
                 end
                 stat.Q(state,action)=sum;
           end
         end

     iter=iter+1;
stat.Q
qvalue_old

     diff_vector=stat.Q-qvalue_old;
     diff=max(abs(diff_vector));
          if diff <epsilon
          done=1;
          end
          if done==0 & iter>ITERMAX
          input('Did not converge in the specified number of iterations\n');
          done=1;
          end

end

iter

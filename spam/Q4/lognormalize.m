function B = lognor( A )
%BINARIZE Summary of this function 
% Binarize is a function to generate binarize matrix by A
% The input of binarize should be a matrix
[r,c]=size(A);  %Get rows and cols of matrix A
B=zeros(r,c);
% aver=mean(A);
% vari=var(A)*(r-1)/r;
for i=1:r   %Using loop to traverse all elements of A,and assume Xij in A is non-nagetive
    for j=1:c
            B(i,j)=log(A(i,j)+0.1);   %If element is larger than double 0.0,then ; 
    end
end
end


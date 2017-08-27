function B = binarize( A )
%BINARIZE Summary of this function 
% Binarize is a function to generate binarize matrix by A
% The input of binarize should be a matrix
[r,c]=size(A);  %Get rows and cols of matrix A
B=zeros(r,c);
for i=1:r   %Using loop to traverse all elements of A,and assume Xij in A is non-nagetive
    for j=1:c
        if A(i,j)>0.0
            B(i,j)=1;   %If element is larger than double 0.0,than Xij=1; 
        else
            B(i,j)=0; %If element is not larger than double 0.0,than Xij=0; 
        end
    end
end
end


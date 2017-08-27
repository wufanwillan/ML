function a = calculaten( Vec )
%CALCULATE Summary of this function goes here
%   This function is to calculate the element numbers of matrix
%   The input should be a vector binarized;
%   The return will be a number of the positive number and the zeros in the
%   vector
n=numel(Vec);%Generate the total number of vector
a=zeros(2,1);%Generate the number of zeros and positive numbers
a(1)=0;%initialize vector of 1
a(2)=0;%initialize vector of 0
for i=1:n%loop
     if Vec(i)>0%justify if the element is positive
         a(1)=a(1)+1;%loop in element to caculate the positive numbers
     else
         a(2)=a(2)+1;%loop in element to caculate the zeros
     end
end
end



function [theta,J]=newton(x,y,lambda)
%֮��Ͳ���������һ���ˡ������theta����Ҳ����n+1�ˡ�
[m, n] = size(x);

% Initialize fitting parameters
theta = zeros(n+1, 1);%������������һ����������
xx=ones(m,1);
x=[xx x];
% Define the sigmoid function
g = inline('1.0 ./ (1.0 + exp(-z))'); 
% setup for Newton's method
MAX_ITR = 30;%ţ�ٵ������Ĵ���
J = zeros(MAX_ITR, 1);%��ʼ��15�ε�����cost function ֵ��J��Ϊ��֮��ͼ
% Lambda ��L2������Ĳ���
%lambda = 1;%lambda=0,1,10���޸�����ط�������3�ο��Եõ�3�ֽ����
% Newton's Method
del=cell(MAX_ITR);
for i = 1:MAX_ITR
   z = x * theta;
   h = sigmoid(z');%m*1
   h=h';
   % Calculate J (for testing convergence)
%    J(i) =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h))+ (lambda/(2*m))*norm(theta([2:end]))^2;
   J(i) =sum(-y.*log(h+eps) - (1-y).*log(1-h+eps))+ (lambda/(2))*norm(theta([2:end]))^2;

   % Calculate gradient and hessian.
%    G = (lambda/m).*theta; 
%    G(1) = 0; 
     G = (lambda).*theta; 
     G(1) = 0; 
   % extra term for gradient 
%    L = (lambda/m).*eye(n);
%    L(1) = 0;
     L = (lambda).*eye(n+1);
     L(1) = 0;
%    grad = ((1/m).*x' * (h-y)) + G;
%    H = ((1/m).*x' * diag(h) * diag(1-h) * x) + L;
    
     grad = x' * (h-y) + G;
     %del{i}=grad;
     H = (x' * diag(h) * diag(1-h) * x) + L;
    if i>1
       delta=(abs(J(i)-J(i-1))/J(i-1));
       if delta<1e-4
           break;
       end
   end

   % Here is the actual update
   theta = theta -H\grad;
   
  
end
end

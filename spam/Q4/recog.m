function result = recog( K_labels,class_num )

[~,K] = size(K_labels);
class_count = zeros(1,class_num+1);
for i=1:K
    class_index = K_labels(i)+1; % +1 is to avoid the 0 index reference.
    class_count(class_index) = class_count(class_index) + 1;
end
[~,result] = max(class_count);
if class_count(1)==class_count(2)
    result=1;
else
    result = result - 1; 
end

end


function [dists, neighbors] = top_K_neighbors(x_train, y_train, x, K)
% [size_x,~] = size(x_train)
[~,size_x] = size(x_train);
% test_mat = repmat(x,size_x,1); 
test_mat = repmat(x,1,size_x); 


%dist_mat = (x_train-double(test_mat)).^2; % 
dist_mat=(x_train-double(test_mat)) .^2;
dist_array = sum(dist_mat); 
%size(dist_array)
[dists,neighbors] = sort(dist_array); 
dists = dists(1:K); % 
neighbors = neighbors(1:K);
%[dists,nerghbors]=pdist2(x_train,test_mat,'hamming',K);
end
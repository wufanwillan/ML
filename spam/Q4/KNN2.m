function y = KNN2(X, X_train, y_train, K)
%KNN k-Nearest Neighbors Algorithm.hamminf

[~,N_test] = size(X);

predicted_label = zeros(1,N_test);
for i=1:N_test
    [dists, neighbors] = top_K_neighbors2(X_train,y_train,X(:,i),K); 
    % calculate the K nearest neighbors and the distances.
    predicted_label(i) = recog(y_train(neighbors),max(y_train));
    % recognize the label of the test vector.
end

y = predicted_label;

end
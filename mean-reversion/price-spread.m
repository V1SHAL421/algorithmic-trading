lookback=20; // window size
hedgeRatio-Nan(size(x, 1), 1); // vector of NaN values with same size as var x
for t=lookback:size(hedgeRatio, 1) // iterates through time steps from lookback to size of hedgeRatio
    regression_result=ols(y(t-lookback+1:t), ...
        [x(t-lookback+1:t) ones(lookback, 1)]); // performs regression using ordinary least squares func
    hedgeRatio(t) = regression_result.beta(1); // slope of regression
end
y2=[x, y];
yport=sum([-hedgeRatio ones(size(hedgeRatio))].*y2, 2);
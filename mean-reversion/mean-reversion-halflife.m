// <!-- Computing half-life for mean reversion

// To determine whether USD/CAD is a good candidate for mean reversion
// trading we will now determine its half-life of mean reversion -->

ylag=lag(y, 1) // Shift time series y by one time step
deltaY=y-ylag; // Calculate difference between consecutive values
deltaY(1)=[]; // Remove 1st element since it is undefined
ylag(1)=[]; // Remove 1st element of ylag as well
regress_results=ols(deltaY, [ylag ones(size(ylag))]);
halflife=-log(2)/regress_results.beta(1); // Calculate the half-life of mean reversion
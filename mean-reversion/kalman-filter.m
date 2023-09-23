/*
implementing a Kalman filter to iteratively estimate the parameters of a linear regression
model while considering measurement and process noise. 
*/

x = [x ones(size(x))]; // adds column of ones to z matrix creating a design matrix for linear regression model
delta = 0.0001; // smoothing factor used in calculations
yhat = NaN(size(y)); // predicted values
e = NaN(size(y)); // residuals
Q = NaN(size(y)); // innovation covariance

P = zeros(2); // covariance matrix of state estimate
beta = NaN(2, size(x, 1)); // holds parameter estimates of linear regression model
Vw = delta / (1-delta) * diag(ones(2, 1)); // process noise covariance matrix
Ve = 0.001; // variance noise covariance matrix
beta(:, 1) = 0;
for t = 1:length(y) // iterates through observations of data (time steps)
    if (t > 1)
        beta(:, t) = beta(:, t-1);
        R = P + Vw;
    end
    yhat(t) = x(t, :) * beta(:, t);
    Q(t) = x(t, :)R * x(t, :) '+ Ve;
    e(t) = y(t) - yhat(t)
    K = R * x(t, :)'/Q(t);
    beta(:, t) = beta(:, t) + K * e(t);
    P = R - K * x(t, :) * R;
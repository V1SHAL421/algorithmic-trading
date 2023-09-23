lookback=round(halflife); // calculates lookback period based on previously calculated halflife

mktValue=-(y-movingAvg(y, lookback))./movingStd(y, lookback) // calculates market value
// calculates difference between time series y and moving avaerage oand then divides by
// moving standard deviation of lookback period
pnl=lag(mktVal, 1).*(y-lag(y, 1))./lag(y, 1);
// computes profit and loss (P&L)
// multiplies lagged market value by difference between current time series value y and its
// lagged value then divides by the lagged value of y

// lookback: period where historical data is considered
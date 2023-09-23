lookback=round(halflife);
numUnits=-(yport-movingAvg(yport, lookback))... // n.o. of units for trading positions
  ./movingStd(yport, lookback);
  positions=repmat(numUnits, [1 size(y3, 2)]).*repmat(results... // trading positions
  // calculated by multiplying numUnits by the first eigenvector of 'results' and then
  // by element-wise multiplying with y3. This generates the trading positions based on the
  // calculated signals
  evec(:, 1)', [size(y3, 1) 1]').*y3;
pnl=sum(lag(positions, 1).*(y3-lag(y3, 1))./lag(y3, 1), 2); // profit and loss
// calculated by summing the product of lagged trading positions, the difference between y3
// and lagged y3, and the ratio of y3 to lagged y3
ret=pnl./sum(abs(lag(positions, 1)), 2); // returns
// calculated by dividng pnl by sum of absolute values of lagged positions
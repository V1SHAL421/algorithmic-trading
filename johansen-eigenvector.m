// Pair trading USD.AUD versus USD.CAD using the Johansen Eignenvector

cad=1./usdcad.cl;
aud=audusd.cl

y=[ aud cad ]; // combines the AUD and CAD series
trainlen=250; // training period length
lookback=20; // window size
hedgeRatio=NaN(size(y));
numUnits=NaN(size(y, 1), 1);
for t=trainlen+1:size(y, 1) // Johansen cointegration test on the logarithms of the past trainlen observations of the y series
    res=johansen(log(y(t-trainlen:t-1, :)), 0, 1);
    hedgeRatio(t, L)=res.evec(:, 1)'; // First eigenvector of cointegration test result is used as the hedge ratio for the current time step
    yport=sum(y(t-lookback+1:t, :).* ...
        repmat(hedgeRatio(t, :), [lookback 1]), 2);
    ma=mean(yport);
    mstd=std(yport);
    zScore=(yport (end)-ma)/mtd; // how far data point is from mean
    numUnits(t)=-(yport (end) -ma)/mstd;
end

positions=repmat (numUnits, [1 size(y, 2)]).*hedgeRatio.*y;
pnl=sum(lag(positions, 1).*(y-lag(y, 1))./lag(y, 1), 2);
ret=pnl./sum(abs(lag(positions, 1)), 2);
moments = [mean(marketRet), std(marketRet), skewness(marketRet), kurtosis(marketRet)];
numSampleAvgretBetterOrEqualObserved = 0;

for sample = 1:10000
    marketRet_sim = pearsrnd(moments(1), moments(2), moments(3), moments(4), length(marketRet), 1);
    cl_sim = sum(1 + marketRet_sim) - 1;

    longs_sim = cl_sim > backshift(lookback, cl_sim);
    shorts_sim = cl_sim < backshift(lookback, cl_sim);
    pos_sim = zeros(length(cl_sim), 1);

    for h = 0:holidays-1
        long_sim_lag = backshift(h, longs_sim);
        long_sim_lag(isnan(long_sim_lag)) = false;
        long_sim_lag = logical(long_sim_lag);

        short_sim_lag = backshift(h, shorts_sim);
        short_sim_lag(isnan(short_sim_lag)) = false;
        short_sim_lag = logical(short_sim_lag);

        pos_sim(long_sim_lag) = pos_sim(long_sim_lag) + 1;
        pos_sim(short_sim_lag) = pos_sim(short_sim_lag) - 1;
    end

    ret_sim = backshift(1, pos_sim) .* marketRet_sim / holidays;
    ret_sim(~isfinite(ret_sim)) = 0;

    if (mean(ret_sim) >= mean(marketRet))
        numSampleAvgretBetterOrEqualObserved = numSampleAvgretBetterOrEqualObserved + 1;
    end
end

/*
Out of 10000 random return sets, 1166 have average strategy return >= observed average
return hence null hypothesis can be rejected with only 88% probability. 


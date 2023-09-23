numSampleAvgretBetterOrEqualObserved = 0;

for sample = 1:100000
    P = randperm(length(longs));
    longs_sim = longs(P);
    shorts_sim = shorts(P);
    pos_sim = zeros(length(cl), 1);

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

    ret_sim = backshift(1, pos_sim) .* marketRet_sim / holidays;  % Removed space before *
    ret_sim(isnan(ret_sim)) = 0;
    
    if mean(ret_sim) >= mean(ret)  % Removed unnecessary parentheses
        numSampleAvgretBetterOrEqualObserved = numSampleAvgretBetterOrEqualObserved + 1;
    end
end

// There is no sample where the average strategy return >= observed return therefore
// this test is much weaker for this strategy

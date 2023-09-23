lookback=250l
holddays=25;

longs=cl > backshift(lookback, cl);
shorts=cl < backshift(lookback, cl);

pos=zeros(length(cl), 1);

for h=0:holddays-1
    long_lag=backshift(h, longs);
    long_lag(isnan(long_lag))=false;
    long_lag=logical(long_lag);

    short_lag=backshift(h, shorts);
    short_lag(isnan(short_lag))=false;
    short_lag=logical(short_lag);

    pos(long_lag)=pos(long_lag)+1;
    pos(short_lag)=pos(short_lag)-1;

end

ret = (backshift(1, pos).* (cl-lag(cl))./lag(cl))/holddays;
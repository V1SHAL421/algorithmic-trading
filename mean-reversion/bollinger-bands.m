entryZscore=1; // entry and exit position thresholds
exitZscore=0;

zScore=(yport-movingAvg(yport, lookback))./movingStd(yport, ...
    lookback);

// define logical conditions for entering and exiting long and short positions
longsEntry = zScore < -entryZscore;
longsExit = zScore >= -exitZscore;
shortsEntry = zScore > entryZscore;
shortsExit = zScore <= exitZscore;
 // units for short and long positions
numUnitsLong = NaN(length(yport), 1);
numUnitsShort = NaN(length(yport), 1);

numUnitsLong(1) = 0;
numUnitsLong(longsEntry) = 1;
numUnitsLong(longsExit) = 0;
numUnitsLong = fillMissingData(numUnitsLong);

numUnitsShort(1) = 0;
numUnitsShort(shortsEntry) = -1
numUnitsShort(shortsExit) = 0;
numUnitsShort = fillMissingData(numUnitsShort);
numUnits = numUnitsLong + numUnitsShort
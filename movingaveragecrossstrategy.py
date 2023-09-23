import pandas as pd
import backtrader as bt

class MovingAverageCrossStrategy(bt.Strategy):
    params = (
        ("short_period", 20),
        ("long_period", 50)
    )

    def __init__(self):
        self.short_ma = bt.indicators.SimpleMovingAverage(
            self.data.close, period=self.params.short_period
        )
        self.long_ma = bt.indicators.SimpleMovingAverage(
            self.data.close, period=self.params.long_period
        )

    def next(self):
        if self.short_ma > self.long_ma:
            # Crossed above, generate a buy signal
            self.buy()
        elif self.short_ma < self.long_ma:
            # Crossed below, generate a sell signal
            self.sell()

if __name__ == "__main__":
    cerebro = bt.Cerebro()
    data = pd.read_csv("your_price_data.csv", parse_dates=True, index_col="Date")
    # replace CSV file with historical price data CSV file
    datafeed = bt.feeds.PandasData(dataname=data)
    cerebro.adddata(datafeed)
    cerebro.addstrategy(MovingAverageCrossStrategy)
    cerebro.run()

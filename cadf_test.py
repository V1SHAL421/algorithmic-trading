# Cointegrated Augmented Dickey-Fuller test - a statistical test to determine
# the existence of cointegration (relationship between non-stationary time series)
# within a set of time series.

import numpy as np
import pandas as pd
import statsmodels.api as sm
from statsmodels.tsa.stattools import adfuller

url = "https://github.com/rishabh89007/Time_Series_Datasets/raw/main/Coal%20Power.csv"
data = pd.read_csv(url)

# Extract the 'x' (electric power) and 'y' (Coal) columns
x = data["electric power (total)"]
y = data["Coal"]
observations = 200  # number of observations
x = np.cumsum(np.random.randn(observations))  # sum of random normal values
y = np.cumsum(np.random.randn(observations))


# conduct CADF test
def cadf_test(y, x):
    model = sm.OLS(
        y, sm.add_constant(x)
    )  # estimate linear relationship between the two time series
    residuals = (
        model.fit().resid
    )  # differences between observed values and predicted values

    adf_result = adfuller(
        residuals
    )  # checks if residuals are stationary (no unit root)
    adf_statistic = adf_result[0]
    alpha = adf_result[1]
    # test statistic and significance level

    return adf_statistic, alpha


adf_statistic, alpha = cadf_test(y, x)
print(f"ADF Statistic: {adf_statistic}")
print(f"Significance level: {alpha}")

if alpha < 0.05:  # strength of evidence against null hypothesis
    print(  # accepts null hypothesis
        "Enough evidence to declare the residuals as stationary - cointegration may be involved."
    )
else:
    print(  # rejects null hypothesis
        "Not enough evidence to declare the residuals as stationary - no cointegration involved."
    )

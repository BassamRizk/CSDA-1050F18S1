# csda 1050 template
## Straddle Selection Tool
# Bassam Rizk YU# 303525

Presentation with audio found here https://1drv.ms/p/s!AhOBDDtkkBk4hr0x8oMUUt3AcSFulg?e=e95MHk 

# Background
* Straddle is an advanced options trading strategy where the trader expects high volatility levels on the stock, as a result of that a trader would buy an equivalent count of ATM – At-The-Money call and put options at the same strike price within the same expiry bucket.
The key challenge in selecting a good straddle opportunity would be predicting with a certain level of certainty which stocks will exhibit abnormal volatility in the foreseeable future.

* The purpose of this project is to predict the volatility on S&P 100 stocks.

* Other challenges that are beyond the scope of this paper but usually faced with straddle are Beta (correlation of the stock with the market) and Greeks (a bunch relationship metrics between the option price and time, stock price...)

# Research Question
What is the highest reachable consistency in screening stocks that will exhibit abnormal price volatility at a foreseeable market or stock event (dividends announcement…)? 

## What I did?
# data acquisition & exploration; consolidate, transform & clean key variables of S&P100 stocks:
* Downloaded individual stock information (high, low, open & close…)
* Captured dividend events (amounts & date) and merged it with data set
* Measured overnight and high/low stock price volatility during the last 12 years
* Performed rounds of cleaning of NAs and transform all values into numeric.
* Merged all 100 individual stock information into 1 data set
* Divided this data into training (70%), validation (15%) and testing (15%) sets
* Ran a principal component analysis - on training data set
* Clustering for optimal straddle opportunities using training data set and targeting prediction of HLPPC – High Low Percentage Price Change

# Models used
* Decision Trees
* Neural Network
* Linear regression

Using testing data set: Tested all 3 methods to identify the best selection method.

### Installation
# R-Studio libraries
```sh
INSTALL.PACKAGES(quandl)
INSTALL.PACKAGES(QuantTools)
INSTALL.PACKAGES(quantmod)
INSTALL.PACKAGES(derivmkts)
INSTALL.PACKAGES(RND)
setDefaults(getSymbols.av, api.key="V7YC53BOMBUB28FJ")
```

# Rattle

```sh
INSTALL.PACKAGES("RATTLE")
INSTALL.PACKAGES("RATTLE", DEPENDENCIES=C("DEPENDS", "SUGGESTS"))
LIBRARY(RATTLE)
RATTLE()
```
# Updates Limitations Requirements?

https://cran.r-project.org/src/contrib/Archive/RGtk2/RGtk2_2.20.35.tar.gz 

In case of a difficulty to open .rattle files in RGtk2 – please use the above link to download the earlier 2.20.35 version of RGtk2 library – that should solve the issue.


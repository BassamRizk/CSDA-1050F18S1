# csda 1050

### Sprint 1 Straddle screening tool Bassam Rizk - YU id 303525 
 
## Research Question 
What is the highest reachable consistency in screening stocks that will exhibit abnormal price volatility at a foreseeable market or stock event (dividends announcement…)?  

Candidate stocks should have their at-the-money options tree premiums exhibiting high correlation (positive for calls and/or negative for puts) with their underlying stocks’ prices.  

## Data sources 
• S&P 100 list of symbols - Wikipedia 
• S&P 100 Stock historical (12 years) – API from Quantmod; QuantTools 
• S&P 100 stock historical events – API from Quantmod 
• Option Tree historical data (call on select stocks in sprint 2) – Quantmod; QuantTools 
• Greeks historical data (call on select stocks in sprint 2) – API from fOptions  

## Update summary 
After a struggle in tying back API feeds from QuantTools & Quantmod – I entertained the idea of leveraging csv download of S&P 500 I refined my data set to S&P 500 and with hours on google I was able to find ways to marry both libraries...

So I moved back to APIs from QuantMod & QuantTools (vs Kaggle) and did the following:

✓ # Downloaded S&P100 stocks individually via “getSymbols”  
✓ # From here onward this is a coding heavy exercise – as I had to maintain all 100 symbols separate in xts files to be able to use library functions 
✓ #Added dividend & stock splits events so to model causality / correlation of events with abnormal volatility (head to clean the data from NAs) 
✓ #calculated trailing volatility for each stock (This was a data – prep /cleanup pain!!) 
✓ #transformed data to enable moving it from xts format to data frame – head to individually clean data of each column from factor to numeric – without making decimals as integers (that was a few hours process) 
✓ # merged all 100 S&P stocks into a central clean data frame.  

## R Studio Libraries 
library(quandl) 
library(QuantTools) 
library(quantmod) 
library(derivmkts) 
library(RND) 
setDefaults(getSymbols.av, api.key="V7YC53BOMBUB28FJ") 

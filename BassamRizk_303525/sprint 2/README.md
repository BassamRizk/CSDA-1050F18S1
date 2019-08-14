
# csda 1050

## Sprint 1

##### Straddle screening tool
## Bassam Rizk - YU id 303525

### Research Question
What is the highest reachable consistency in screening stocks that will exhibit abnormal price volatility at a foreseeable market or stock event (dividends announcement…)? 
Candidate stocks should have their at-the-money options tree premiums exhibiting high correlation (positive for calls and/or negative for puts) with their underlying stocks’ prices. 

## Data sources	
 •	S&P 100 list of symbols - Wikipedia
 •	S&P 100 Stock historical (12 years) – API from Quantmod; QuantTools
 •	S&P 100 stock historical events – API from Quantmod
 •	Option Tree historical data (call on select stocks in sprint 2) – Quantmod; QuantTools
 •	Greeks historical data (call on select stocks in sprint 2) – API from fOptions 

### Update summary
 To make sure I can meet all deadlines – I have taken the path of leveraging Rattle package in R Studio for clustering, modeling…

 Rattle is a popup interface that calls upon 100s of other packages in the background. It offers all phases of modeling from exploration/transformation/clustering/modeling/testing/validating.

 For my data to be ready for raddle and to avoid transformation within Rattle, I went back and added a key field – HLPPC – High Low Percentage Change - that measures the percentage price gap within each day’s high and low price points.

Below is a bird eye view of what was done in Sprint 2:
 	Pre-raddle transformation – adding HLPPC
 	Principal component review of the aggregated data set S&P100Full
 	Splitting the data into training, validation & testing.
 	Clustering the data set S&P100Full (K means, EWKM…)
 	Modeling the data for HLPPC (using decision tree, neural network & linear)
 	Validating & testing all 3 models.

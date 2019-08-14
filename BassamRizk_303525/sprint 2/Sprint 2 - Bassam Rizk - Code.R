---
  title: "Straddle Screening Tool"
# Bassam Rizk
# YUid 303525
output: html_notebook
---
  
  ### Research Question
  # What is the highest reachable consistency in screening stocks that will exhibit abnormal price volatility at a foreseeable market or stock event (dividends announcement.)? 
  # Candidate stocks should have their at-the-money options tree premiums exhibiting high correlation (positive for calls and negative for puts) with their underlying stocks' prices. 
  

library(QuantTools)
library(quantmod)
library(derivmkts)
library(RND)
library(dplyr)
library(reshape2)
library(rattle)

rattle()

setDefaults(getSymbols.av, api.key="V7YC53BOMBUB28FJ")
  
## Post Srint 1 addition
    ### I noticed that I will need percent price change as a variable in any of my clustering & models - adding that to the merged full SnP100 file might be tricky
  
    ### I added % closing price change column to the consolidated data frame


SnP100full$PerChange <- c(-diff(SnP100full$Close)/SnP100full$Close[-1]*100,0)

# Challenges: Did a dry run on a test sample and have 2 challenges in running Clustering functions:
          #there are still NAs in relatively newer stocks (e.g. Netflix...) that were not existant throughout the 2007-2019 sample period.
          #Preset library functions for measuring percentage price change (Overnight & intra-day) do not seem to be compatible with various clustering functions.

# Solutions: will go back to the individual stock data frames and do couple of clean-ups:
      #Transform all remaining NAs in individual data sets into nill value
      # add overnight and same day percentage price change
      # remerge the individual 100 stock data frames into a new large data frame

  #Transform all remaining NAs in individual data sets into nill value
AAPLfull[is.na(AAPLfull)] <-0
ABBVfull[is.na(ABBVfull)] <-0
ABTfull[is.na(ABTfull)] <-0
ACNfull[is.na(ACNfull)] <-0
ADBEfull[is.na(ADBEfull)] <-0
AGNfull[is.na(AGNfull)] <-0
AIGfull[is.na(AIGfull)] <-0
ALLfull[is.na(ALLfull)] <-0
AMGNfull[is.na(AMGNfull)] <-0
AMZNfull[is.na(AMZNfull)] <-0
AXPfull[is.na(AXPfull)] <-0
BAfull[is.na(BAfull)] <-0
BACfull[is.na(BACfull)] <-0
BIIBfull[is.na(BIIBfull)] <-0
BKfull[is.na(BKfull)] <-0
BKNGfull[is.na(BKNGfull)] <-0
BLKfull[is.na(BLKfull)] <-0
BMYfull[is.na(BMYfull)] <-0
Cfull[is.na(Cfull)] <-0
CATfull[is.na(CATfull)] <-0
CELGfull[is.na(CELGfull)] <-0
CHTRfull[is.na(CHTRfull)] <-0
CLfull[is.na(CLfull)] <-0
CMCSAfull[is.na(CMCSAfull)] <-0
COFfull[is.na(COFfull)] <-0
COPfull[is.na(COPfull)] <-0
COSTfull[is.na(COSTfull)] <-0
CSCOfull[is.na(CSCOfull)] <-0
CVSfull[is.na(CVSfull)] <-0
CVXfull[is.na(CVXfull)] <-0
DDfull[is.na(DDfull)] <-0
DHRfull[is.na(DHRfull)] <-0
DISfull[is.na(DISfull)] <-0
DOWfull[is.na(DOWfull)] <-0
DUKfull[is.na(DUKfull)] <-0
EMRfull[is.na(EMRfull)] <-0
EXCfull[is.na(EXCfull)] <-0
Ffull[is.na(Ffull)] <-0
FBfull[is.na(FBfull)] <-0
FDXfull[is.na(FDXfull)] <-0
GDfull[is.na(GDfull)] <-0
GEfull[is.na(GEfull)] <-0
GILDfull[is.na(GILDfull)] <-0
GMfull[is.na(GMfull)] <-0
GOOGfull[is.na(GOOGfull)] <-0
GOOGLfull[is.na(GOOGLfull)] <-0
GSfull[is.na(GSfull)] <-0
HDfull[is.na(HDfull)] <-0
HONfull[is.na(HONfull)] <-0
IBMfull[is.na(IBMfull)] <-0
INTCfull[is.na(INTCfull)] <-0
JNJfull[is.na(JNJfull)] <-0
JPMfull[is.na(JPMfull)] <-0
KHCfull[is.na(KHCfull)] <-0
KMIfull[is.na(KMIfull)] <-0
KOfull[is.na(KOfull)] <-0
LLYfull[is.na(LLYfull)] <-0
LMTfull[is.na(LMTfull)] <-0
LOWfull[is.na(LOWfull)] <-0
MAfull[is.na(MAfull)] <-0
MCDfull[is.na(MCDfull)] <-0
MDLZfull[is.na(MDLZfull)] <-0
MDTfull[is.na(MDTfull)] <-0
METfull[is.na(METfull)] <-0
MMMfull[is.na(MMMfull)] <-0
MOfull[is.na(MOfull)] <-0
MRKfull[is.na(MRKfull)] <-0
MSfull[is.na(MSfull)] <-0
MSFTfull[is.na(MSFTfull)] <-0
NEEfull[is.na(NEEfull)] <-0
NFLXfull[is.na(NFLXfull)] <-0
NKEfull[is.na(NKEfull)] <-0
NVDAfull[is.na(NVDAfull)] <-0
ORCLfull[is.na(ORCLfull)] <-0
OXYfull[is.na(OXYfull)] <-0
PEPfull[is.na(PEPfull)] <-0
PFEfull[is.na(PFEfull)] <-0
PGfull[is.na(PGfull)] <-0
PMfull[is.na(PMfull)] <-0
PYPLfull[is.na(PYPLfull)] <-0
QCOMfull[is.na(QCOMfull)] <-0
RTNfull[is.na(RTNfull)] <-0
SBUXfull[is.na(SBUXfull)] <-0
SLBfull[is.na(SLBfull)] <-0
SOfull[is.na(SOfull)] <-0
SPGfull[is.na(SPGfull)] <-0
Tfull[is.na(Tfull)] <-0
TGTfull[is.na(TGTfull)] <-0
TXNfull[is.na(TXNfull)] <-0
UNHfull[is.na(UNHfull)] <-0
UNPfull[is.na(UNPfull)] <-0
UPSfull[is.na(UPSfull)] <-0
USBfull[is.na(USBfull)] <-0
UTXfull[is.na(UTXfull)] <-0
Vfull[is.na(Vfull)] <-0
VZfull[is.na(VZfull)] <-0
WBAfull[is.na(WBAfull)] <-0
WFCfull[is.na(WFCfull)] <-0
WMTfull[is.na(WMTfull)] <-0
XOMfull[is.na(XOMfull)] <-0



# add overnight and same day percentage price change
# start with overnight (difference between close of the day and the previous day)
AAPLfull$ON_PPC<- c(-diff(AAPLfull$Close)/AAPLfull$Close[-1]*100,0)
ABBVfull$ON_PPC<- c(-diff(ABBVfull$Close)/ABBVfull$Close[-1]*100,0)
ABTfull$ON_PPC<- c(-diff(ABTfull$Close)/ABTfull$Close[-1]*100,0)
ACNfull$ON_PPC<- c(-diff(ACNfull$Close)/ACNfull$Close[-1]*100,0)
ADBEfull$ON_PPC<- c(-diff(ADBEfull$Close)/ADBEfull$Close[-1]*100,0)
AGNfull$ON_PPC<- c(-diff(AGNfull$Close)/AGNfull$Close[-1]*100,0)
AIGfull$ON_PPC<- c(-diff(AIGfull$Close)/AIGfull$Close[-1]*100,0)
ALLfull$ON_PPC<- c(-diff(ALLfull$Close)/ALLfull$Close[-1]*100,0)
AMGNfull$ON_PPC<- c(-diff(AMGNfull$Close)/AMGNfull$Close[-1]*100,0)
AMZNfull$ON_PPC<- c(-diff(AMZNfull$Close)/AMZNfull$Close[-1]*100,0)
AXPfull$ON_PPC<- c(-diff(AXPfull$Close)/AXPfull$Close[-1]*100,0)
BAfull$ON_PPC<- c(-diff(BAfull$Close)/BAfull$Close[-1]*100,0)
BACfull$ON_PPC<- c(-diff(BACfull$Close)/BACfull$Close[-1]*100,0)
BIIBfull$ON_PPC<- c(-diff(BIIBfull$Close)/BIIBfull$Close[-1]*100,0)
BKfull$ON_PPC<- c(-diff(BKfull$Close)/BKfull$Close[-1]*100,0)
BKNGfull$ON_PPC<- c(-diff(BKNGfull$Close)/BKNGfull$Close[-1]*100,0)
BLKfull$ON_PPC<- c(-diff(BLKfull$Close)/BLKfull$Close[-1]*100,0)
BMYfull$ON_PPC<- c(-diff(BMYfull$Close)/BMYfull$Close[-1]*100,0)
Cfull$ON_PPC<- c(-diff(Cfull$Close)/Cfull$Close[-1]*100,0)
CATfull$ON_PPC<- c(-diff(CATfull$Close)/CATfull$Close[-1]*100,0)
CELGfull$ON_PPC<- c(-diff(CELGfull$Close)/CELGfull$Close[-1]*100,0)
CHTRfull$ON_PPC<- c(-diff(CHTRfull$Close)/CHTRfull$Close[-1]*100,0)
CLfull$ON_PPC<- c(-diff(CLfull$Close)/CLfull$Close[-1]*100,0)
CMCSAfull$ON_PPC<- c(-diff(CMCSAfull$Close)/CMCSAfull$Close[-1]*100,0)
COFfull$ON_PPC<- c(-diff(COFfull$Close)/COFfull$Close[-1]*100,0)
COPfull$ON_PPC<- c(-diff(COPfull$Close)/COPfull$Close[-1]*100,0)
COSTfull$ON_PPC<- c(-diff(COSTfull$Close)/COSTfull$Close[-1]*100,0)
CSCOfull$ON_PPC<- c(-diff(CSCOfull$Close)/CSCOfull$Close[-1]*100,0)
CVSfull$ON_PPC<- c(-diff(CVSfull$Close)/CVSfull$Close[-1]*100,0)
CVXfull$ON_PPC<- c(-diff(CVXfull$Close)/CVXfull$Close[-1]*100,0)
DDfull$ON_PPC<- c(-diff(DDfull$Close)/DDfull$Close[-1]*100,0)
DHRfull$ON_PPC<- c(-diff(DHRfull$Close)/DHRfull$Close[-1]*100,0)
DISfull$ON_PPC<- c(-diff(DISfull$Close)/DISfull$Close[-1]*100,0)
DOWfull$ON_PPC<- c(-diff(DOWfull$Close)/DOWfull$Close[-1]*100,0)
DUKfull$ON_PPC<- c(-diff(DUKfull$Close)/DUKfull$Close[-1]*100,0)
EMRfull$ON_PPC<- c(-diff(EMRfull$Close)/EMRfull$Close[-1]*100,0)
EXCfull$ON_PPC<- c(-diff(EXCfull$Close)/EXCfull$Close[-1]*100,0)
Ffull$ON_PPC<- c(-diff(Ffull$Close)/Ffull$Close[-1]*100,0)
FBfull$ON_PPC<- c(-diff(FBfull$Close)/FBfull$Close[-1]*100,0)
FDXfull$ON_PPC<- c(-diff(FDXfull$Close)/FDXfull$Close[-1]*100,0)
GDfull$ON_PPC<- c(-diff(GDfull$Close)/GDfull$Close[-1]*100,0)
GEfull$ON_PPC<- c(-diff(GEfull$Close)/GEfull$Close[-1]*100,0)
GILDfull$ON_PPC<- c(-diff(GILDfull$Close)/GILDfull$Close[-1]*100,0)
GMfull$ON_PPC<- c(-diff(GMfull$Close)/GMfull$Close[-1]*100,0)
GOOGfull$ON_PPC<- c(-diff(GOOGfull$Close)/GOOGfull$Close[-1]*100,0)
GOOGLfull$ON_PPC<- c(-diff(GOOGLfull$Close)/GOOGLfull$Close[-1]*100,0)
GSfull$ON_PPC<- c(-diff(GSfull$Close)/GSfull$Close[-1]*100,0)
HDfull$ON_PPC<- c(-diff(HDfull$Close)/HDfull$Close[-1]*100,0)
HONfull$ON_PPC<- c(-diff(HONfull$Close)/HONfull$Close[-1]*100,0)
IBMfull$ON_PPC<- c(-diff(IBMfull$Close)/IBMfull$Close[-1]*100,0)
INTCfull$ON_PPC<- c(-diff(INTCfull$Close)/INTCfull$Close[-1]*100,0)
JNJfull$ON_PPC<- c(-diff(JNJfull$Close)/JNJfull$Close[-1]*100,0)
JPMfull$ON_PPC<- c(-diff(JPMfull$Close)/JPMfull$Close[-1]*100,0)
KHCfull$ON_PPC<- c(-diff(KHCfull$Close)/KHCfull$Close[-1]*100,0)
KMIfull$ON_PPC<- c(-diff(KMIfull$Close)/KMIfull$Close[-1]*100,0)
KOfull$ON_PPC<- c(-diff(KOfull$Close)/KOfull$Close[-1]*100,0)
LLYfull$ON_PPC<- c(-diff(LLYfull$Close)/LLYfull$Close[-1]*100,0)
LMTfull$ON_PPC<- c(-diff(LMTfull$Close)/LMTfull$Close[-1]*100,0)
LOWfull$ON_PPC<- c(-diff(LOWfull$Close)/LOWfull$Close[-1]*100,0)
MAfull$ON_PPC<- c(-diff(MAfull$Close)/MAfull$Close[-1]*100,0)
MCDfull$ON_PPC<- c(-diff(MCDfull$Close)/MCDfull$Close[-1]*100,0)
MDLZfull$ON_PPC<- c(-diff(MDLZfull$Close)/MDLZfull$Close[-1]*100,0)
MDTfull$ON_PPC<- c(-diff(MDTfull$Close)/MDTfull$Close[-1]*100,0)
METfull$ON_PPC<- c(-diff(METfull$Close)/METfull$Close[-1]*100,0)
MMMfull$ON_PPC<- c(-diff(MMMfull$Close)/MMMfull$Close[-1]*100,0)
MOfull$ON_PPC<- c(-diff(MOfull$Close)/MOfull$Close[-1]*100,0)
MRKfull$ON_PPC<- c(-diff(MRKfull$Close)/MRKfull$Close[-1]*100,0)
MSfull$ON_PPC<- c(-diff(MSfull$Close)/MSfull$Close[-1]*100,0)
MSFTfull$ON_PPC<- c(-diff(MSFTfull$Close)/MSFTfull$Close[-1]*100,0)
NEEfull$ON_PPC<- c(-diff(NEEfull$Close)/NEEfull$Close[-1]*100,0)
NFLXfull$ON_PPC<- c(-diff(NFLXfull$Close)/NFLXfull$Close[-1]*100,0)
NKEfull$ON_PPC<- c(-diff(NKEfull$Close)/NKEfull$Close[-1]*100,0)
NVDAfull$ON_PPC<- c(-diff(NVDAfull$Close)/NVDAfull$Close[-1]*100,0)
ORCLfull$ON_PPC<- c(-diff(ORCLfull$Close)/ORCLfull$Close[-1]*100,0)
OXYfull$ON_PPC<- c(-diff(OXYfull$Close)/OXYfull$Close[-1]*100,0)
PEPfull$ON_PPC<- c(-diff(PEPfull$Close)/PEPfull$Close[-1]*100,0)
PFEfull$ON_PPC<- c(-diff(PFEfull$Close)/PFEfull$Close[-1]*100,0)
PGfull$ON_PPC<- c(-diff(PGfull$Close)/PGfull$Close[-1]*100,0)
PMfull$ON_PPC<- c(-diff(PMfull$Close)/PMfull$Close[-1]*100,0)
PYPLfull$ON_PPC<- c(-diff(PYPLfull$Close)/PYPLfull$Close[-1]*100,0)
QCOMfull$ON_PPC<- c(-diff(QCOMfull$Close)/QCOMfull$Close[-1]*100,0)
RTNfull$ON_PPC<- c(-diff(RTNfull$Close)/RTNfull$Close[-1]*100,0)
SBUXfull$ON_PPC<- c(-diff(SBUXfull$Close)/SBUXfull$Close[-1]*100,0)
SLBfull$ON_PPC<- c(-diff(SLBfull$Close)/SLBfull$Close[-1]*100,0)
SOfull$ON_PPC<- c(-diff(SOfull$Close)/SOfull$Close[-1]*100,0)
SPGfull$ON_PPC<- c(-diff(SPGfull$Close)/SPGfull$Close[-1]*100,0)
Tfull$ON_PPC<- c(-diff(Tfull$Close)/Tfull$Close[-1]*100,0)
TGTfull$ON_PPC<- c(-diff(TGTfull$Close)/TGTfull$Close[-1]*100,0)
TXNfull$ON_PPC<- c(-diff(TXNfull$Close)/TXNfull$Close[-1]*100,0)
UNHfull$ON_PPC<- c(-diff(UNHfull$Close)/UNHfull$Close[-1]*100,0)
UNPfull$ON_PPC<- c(-diff(UNPfull$Close)/UNPfull$Close[-1]*100,0)
UPSfull$ON_PPC<- c(-diff(UPSfull$Close)/UPSfull$Close[-1]*100,0)
USBfull$ON_PPC<- c(-diff(USBfull$Close)/USBfull$Close[-1]*100,0)
UTXfull$ON_PPC<- c(-diff(UTXfull$Close)/UTXfull$Close[-1]*100,0)
Vfull$ON_PPC<- c(-diff(Vfull$Close)/Vfull$Close[-1]*100,0)
VZfull$ON_PPC<- c(-diff(VZfull$Close)/VZfull$Close[-1]*100,0)
WBAfull$ON_PPC<- c(-diff(WBAfull$Close)/WBAfull$Close[-1]*100,0)
WFCfull$ON_PPC<- c(-diff(WFCfull$Close)/WFCfull$Close[-1]*100,0)
WMTfull$ON_PPC<- c(-diff(WMTfull$Close)/WMTfull$Close[-1]*100,0)
XOMfull$ON_PPC<- c(-diff(XOMfull$Close)/XOMfull$Close[-1]*100,0)



# measure percent change between a day's high & low
AAPLfull$HLppc<- c((AAPLfull$High - AAPLfull$Low)/AAPLfull$Low*100)
ABBVfull$HLppc<- c((ABBVfull$High - ABBVfull$Low)/ABBVfull$Low*100)
ABTfull$HLppc<- c((ABTfull$High - ABTfull$Low)/ABTfull$Low*100)
ACNfull$HLppc<- c((ACNfull$High - ACNfull$Low)/ACNfull$Low*100)
ADBEfull$HLppc<- c((ADBEfull$High - ADBEfull$Low)/ADBEfull$Low*100)
AGNfull$HLppc<- c((AGNfull$High - AGNfull$Low)/AGNfull$Low*100)
AIGfull$HLppc<- c((AIGfull$High - AIGfull$Low)/AIGfull$Low*100)
ALLfull$HLppc<- c((ALLfull$High - ALLfull$Low)/ALLfull$Low*100)
AMGNfull$HLppc<- c((AMGNfull$High - AMGNfull$Low)/AMGNfull$Low*100)
AMZNfull$HLppc<- c((AMZNfull$High - AMZNfull$Low)/AMZNfull$Low*100)
AXPfull$HLppc<- c((AXPfull$High - AXPfull$Low)/AXPfull$Low*100)
BAfull$HLppc<- c((BAfull$High - BAfull$Low)/BAfull$Low*100)
BACfull$HLppc<- c((BACfull$High - BACfull$Low)/BACfull$Low*100)
BIIBfull$HLppc<- c((BIIBfull$High - BIIBfull$Low)/BIIBfull$Low*100)
BKfull$HLppc<- c((BKfull$High - BKfull$Low)/BKfull$Low*100)
BKNGfull$HLppc<- c((BKNGfull$High - BKNGfull$Low)/BKNGfull$Low*100)
BLKfull$HLppc<- c((BLKfull$High - BLKfull$Low)/BLKfull$Low*100)
BMYfull$HLppc<- c((BMYfull$High - BMYfull$Low)/BMYfull$Low*100)
Cfull$HLppc<- c((Cfull$High - Cfull$Low)/Cfull$Low*100)
CATfull$HLppc<- c((CATfull$High - CATfull$Low)/CATfull$Low*100)
CELGfull$HLppc<- c((CELGfull$High - CELGfull$Low)/CELGfull$Low*100)
CHTRfull$HLppc<- c((CHTRfull$High - CHTRfull$Low)/CHTRfull$Low*100)
CLfull$HLppc<- c((CLfull$High - CLfull$Low)/CLfull$Low*100)
CMCSAfull$HLppc<- c((CMCSAfull$High - CMCSAfull$Low)/CMCSAfull$Low*100)
COFfull$HLppc<- c((COFfull$High - COFfull$Low)/COFfull$Low*100)
COPfull$HLppc<- c((COPfull$High - COPfull$Low)/COPfull$Low*100)
COSTfull$HLppc<- c((COSTfull$High - COSTfull$Low)/COSTfull$Low*100)
CSCOfull$HLppc<- c((CSCOfull$High - CSCOfull$Low)/CSCOfull$Low*100)
CVSfull$HLppc<- c((CVSfull$High - CVSfull$Low)/CVSfull$Low*100)
CVXfull$HLppc<- c((CVXfull$High - CVXfull$Low)/CVXfull$Low*100)
DDfull$HLppc<- c((DDfull$High - DDfull$Low)/DDfull$Low*100)
DHRfull$HLppc<- c((DHRfull$High - DHRfull$Low)/DHRfull$Low*100)
DISfull$HLppc<- c((DISfull$High - DISfull$Low)/DISfull$Low*100)
DOWfull$HLppc<- c((DOWfull$High - DOWfull$Low)/DOWfull$Low*100)
DUKfull$HLppc<- c((DUKfull$High - DUKfull$Low)/DUKfull$Low*100)
EMRfull$HLppc<- c((EMRfull$High - EMRfull$Low)/EMRfull$Low*100)
EXCfull$HLppc<- c((EXCfull$High - EXCfull$Low)/EXCfull$Low*100)
Ffull$HLppc<- c((Ffull$High - Ffull$Low)/Ffull$Low*100)
FBfull$HLppc<- c((FBfull$High - FBfull$Low)/FBfull$Low*100)
FDXfull$HLppc<- c((FDXfull$High - FDXfull$Low)/FDXfull$Low*100)
GDfull$HLppc<- c((GDfull$High - GDfull$Low)/GDfull$Low*100)
GEfull$HLppc<- c((GEfull$High - GEfull$Low)/GEfull$Low*100)
GILDfull$HLppc<- c((GILDfull$High - GILDfull$Low)/GILDfull$Low*100)
GMfull$HLppc<- c((GMfull$High - GMfull$Low)/GMfull$Low*100)
GOOGfull$HLppc<- c((GOOGfull$High - GOOGfull$Low)/GOOGfull$Low*100)
GOOGLfull$HLppc<- c((GOOGLfull$High - GOOGLfull$Low)/GOOGLfull$Low*100)
GSfull$HLppc<- c((GSfull$High - GSfull$Low)/GSfull$Low*100)
HDfull$HLppc<- c((HDfull$High - HDfull$Low)/HDfull$Low*100)
HONfull$HLppc<- c((HONfull$High - HONfull$Low)/HONfull$Low*100)
IBMfull$HLppc<- c((IBMfull$High - IBMfull$Low)/IBMfull$Low*100)
INTCfull$HLppc<- c((INTCfull$High - INTCfull$Low)/INTCfull$Low*100)
JNJfull$HLppc<- c((JNJfull$High - JNJfull$Low)/JNJfull$Low*100)
JPMfull$HLppc<- c((JPMfull$High - JPMfull$Low)/JPMfull$Low*100)
KHCfull$HLppc<- c((KHCfull$High - KHCfull$Low)/KHCfull$Low*100)
KMIfull$HLppc<- c((KMIfull$High - KMIfull$Low)/KMIfull$Low*100)
KOfull$HLppc<- c((KOfull$High - KOfull$Low)/KOfull$Low*100)
LLYfull$HLppc<- c((LLYfull$High - LLYfull$Low)/LLYfull$Low*100)
LMTfull$HLppc<- c((LMTfull$High - LMTfull$Low)/LMTfull$Low*100)
LOWfull$HLppc<- c((LOWfull$High - LOWfull$Low)/LOWfull$Low*100)
MAfull$HLppc<- c((MAfull$High - MAfull$Low)/MAfull$Low*100)
MCDfull$HLppc<- c((MCDfull$High - MCDfull$Low)/MCDfull$Low*100)
MDLZfull$HLppc<- c((MDLZfull$High - MDLZfull$Low)/MDLZfull$Low*100)
MDTfull$HLppc<- c((MDTfull$High - MDTfull$Low)/MDTfull$Low*100)
METfull$HLppc<- c((METfull$High - METfull$Low)/METfull$Low*100)
MMMfull$HLppc<- c((MMMfull$High - MMMfull$Low)/MMMfull$Low*100)
MOfull$HLppc<- c((MOfull$High - MOfull$Low)/MOfull$Low*100)
MRKfull$HLppc<- c((MRKfull$High - MRKfull$Low)/MRKfull$Low*100)
MSfull$HLppc<- c((MSfull$High - MSfull$Low)/MSfull$Low*100)
MSFTfull$HLppc<- c((MSFTfull$High - MSFTfull$Low)/MSFTfull$Low*100)
NEEfull$HLppc<- c((NEEfull$High - NEEfull$Low)/NEEfull$Low*100)
NFLXfull$HLppc<- c((NFLXfull$High - NFLXfull$Low)/NFLXfull$Low*100)
NKEfull$HLppc<- c((NKEfull$High - NKEfull$Low)/NKEfull$Low*100)
NVDAfull$HLppc<- c((NVDAfull$High - NVDAfull$Low)/NVDAfull$Low*100)
ORCLfull$HLppc<- c((ORCLfull$High - ORCLfull$Low)/ORCLfull$Low*100)
OXYfull$HLppc<- c((OXYfull$High - OXYfull$Low)/OXYfull$Low*100)
PEPfull$HLppc<- c((PEPfull$High - PEPfull$Low)/PEPfull$Low*100)
PFEfull$HLppc<- c((PFEfull$High - PFEfull$Low)/PFEfull$Low*100)
PGfull$HLppc<- c((PGfull$High - PGfull$Low)/PGfull$Low*100)
PMfull$HLppc<- c((PMfull$High - PMfull$Low)/PMfull$Low*100)
PYPLfull$HLppc<- c((PYPLfull$High - PYPLfull$Low)/PYPLfull$Low*100)
QCOMfull$HLppc<- c((QCOMfull$High - QCOMfull$Low)/QCOMfull$Low*100)
RTNfull$HLppc<- c((RTNfull$High - RTNfull$Low)/RTNfull$Low*100)
SBUXfull$HLppc<- c((SBUXfull$High - SBUXfull$Low)/SBUXfull$Low*100)
SLBfull$HLppc<- c((SLBfull$High - SLBfull$Low)/SLBfull$Low*100)
SOfull$HLppc<- c((SOfull$High - SOfull$Low)/SOfull$Low*100)
SPGfull$HLppc<- c((SPGfull$High - SPGfull$Low)/SPGfull$Low*100)
Tfull$HLppc<- c((Tfull$High - Tfull$Low)/Tfull$Low*100)
TGTfull$HLppc<- c((TGTfull$High - TGTfull$Low)/TGTfull$Low*100)
TXNfull$HLppc<- c((TXNfull$High - TXNfull$Low)/TXNfull$Low*100)
UNHfull$HLppc<- c((UNHfull$High - UNHfull$Low)/UNHfull$Low*100)
UNPfull$HLppc<- c((UNPfull$High - UNPfull$Low)/UNPfull$Low*100)
UPSfull$HLppc<- c((UPSfull$High - UPSfull$Low)/UPSfull$Low*100)
USBfull$HLppc<- c((USBfull$High - USBfull$Low)/USBfull$Low*100)
UTXfull$HLppc<- c((UTXfull$High - UTXfull$Low)/UTXfull$Low*100)
Vfull$HLppc<- c((Vfull$High - Vfull$Low)/Vfull$Low*100)
VZfull$HLppc<- c((VZfull$High - VZfull$Low)/VZfull$Low*100)
WBAfull$HLppc<- c((WBAfull$High - WBAfull$Low)/WBAfull$Low*100)
WFCfull$HLppc<- c((WFCfull$High - WFCfull$Low)/WFCfull$Low*100)
WMTfull$HLppc<- c((WMTfull$High - WMTfull$Low)/WMTfull$Low*100)
XOMfull$HLppc<- c((XOMfull$High - XOMfull$Low)/XOMfull$Low*100)


# removing NAs  
# there seems to be few NAs in few stocks - this applies to period where a stock was not yet listed
# Clean-up - another round of cleaning NAs in the percentage change fields

AAPLfull[is.na(AAPLfull)] <-0
ABBVfull[is.na(ABBVfull)] <-0
ABTfull[is.na(ABTfull)] <-0
ACNfull[is.na(ACNfull)] <-0
ADBEfull[is.na(ADBEfull)] <-0
AGNfull[is.na(AGNfull)] <-0
AIGfull[is.na(AIGfull)] <-0
ALLfull[is.na(ALLfull)] <-0
AMGNfull[is.na(AMGNfull)] <-0
AMZNfull[is.na(AMZNfull)] <-0
AXPfull[is.na(AXPfull)] <-0
BAfull[is.na(BAfull)] <-0
BACfull[is.na(BACfull)] <-0
BIIBfull[is.na(BIIBfull)] <-0
BKfull[is.na(BKfull)] <-0
BKNGfull[is.na(BKNGfull)] <-0
BLKfull[is.na(BLKfull)] <-0
BMYfull[is.na(BMYfull)] <-0
Cfull[is.na(Cfull)] <-0
CATfull[is.na(CATfull)] <-0
CELGfull[is.na(CELGfull)] <-0
CHTRfull[is.na(CHTRfull)] <-0
CLfull[is.na(CLfull)] <-0
CMCSAfull[is.na(CMCSAfull)] <-0
COFfull[is.na(COFfull)] <-0
COPfull[is.na(COPfull)] <-0
COSTfull[is.na(COSTfull)] <-0
CSCOfull[is.na(CSCOfull)] <-0
CVSfull[is.na(CVSfull)] <-0
CVXfull[is.na(CVXfull)] <-0
DDfull[is.na(DDfull)] <-0
DHRfull[is.na(DHRfull)] <-0
DISfull[is.na(DISfull)] <-0
DOWfull[is.na(DOWfull)] <-0
DUKfull[is.na(DUKfull)] <-0
EMRfull[is.na(EMRfull)] <-0
EXCfull[is.na(EXCfull)] <-0
Ffull[is.na(Ffull)] <-0
FBfull[is.na(FBfull)] <-0
FDXfull[is.na(FDXfull)] <-0
GDfull[is.na(GDfull)] <-0
GEfull[is.na(GEfull)] <-0
GILDfull[is.na(GILDfull)] <-0
GMfull[is.na(GMfull)] <-0
GOOGfull[is.na(GOOGfull)] <-0
GOOGLfull[is.na(GOOGLfull)] <-0
GSfull[is.na(GSfull)] <-0
HDfull[is.na(HDfull)] <-0
HONfull[is.na(HONfull)] <-0
IBMfull[is.na(IBMfull)] <-0
INTCfull[is.na(INTCfull)] <-0
JNJfull[is.na(JNJfull)] <-0
JPMfull[is.na(JPMfull)] <-0
KHCfull[is.na(KHCfull)] <-0
KMIfull[is.na(KMIfull)] <-0
KOfull[is.na(KOfull)] <-0
LLYfull[is.na(LLYfull)] <-0
LMTfull[is.na(LMTfull)] <-0
LOWfull[is.na(LOWfull)] <-0
MAfull[is.na(MAfull)] <-0
MCDfull[is.na(MCDfull)] <-0
MDLZfull[is.na(MDLZfull)] <-0
MDTfull[is.na(MDTfull)] <-0
METfull[is.na(METfull)] <-0
MMMfull[is.na(MMMfull)] <-0
MOfull[is.na(MOfull)] <-0
MRKfull[is.na(MRKfull)] <-0
MSfull[is.na(MSfull)] <-0
MSFTfull[is.na(MSFTfull)] <-0
NEEfull[is.na(NEEfull)] <-0
NFLXfull[is.na(NFLXfull)] <-0
NKEfull[is.na(NKEfull)] <-0
NVDAfull[is.na(NVDAfull)] <-0
ORCLfull[is.na(ORCLfull)] <-0
OXYfull[is.na(OXYfull)] <-0
PEPfull[is.na(PEPfull)] <-0
PFEfull[is.na(PFEfull)] <-0
PGfull[is.na(PGfull)] <-0
PMfull[is.na(PMfull)] <-0
PYPLfull[is.na(PYPLfull)] <-0
QCOMfull[is.na(QCOMfull)] <-0
RTNfull[is.na(RTNfull)] <-0
SBUXfull[is.na(SBUXfull)] <-0
SLBfull[is.na(SLBfull)] <-0
SOfull[is.na(SOfull)] <-0
SPGfull[is.na(SPGfull)] <-0
Tfull[is.na(Tfull)] <-0
TGTfull[is.na(TGTfull)] <-0
TXNfull[is.na(TXNfull)] <-0
UNHfull[is.na(UNHfull)] <-0
UNPfull[is.na(UNPfull)] <-0
UPSfull[is.na(UPSfull)] <-0
USBfull[is.na(USBfull)] <-0
UTXfull[is.na(UTXfull)] <-0
Vfull[is.na(Vfull)] <-0
VZfull[is.na(VZfull)] <-0
WBAfull[is.na(WBAfull)] <-0
WFCfull[is.na(WFCfull)] <-0
WMTfull[is.na(WMTfull)] <-0
XOMfull[is.na(XOMfull)] <-0


#re-merging all 100 files after adding overnight and high/close percentage change

SnP100full<- rbind(AAPLfull, ABBVfull, ABTfull, ACNfull, ADBEfull, AGNfull, AIGfull, ALLfull, AMGNfull, AMZNfull, AXPfull, BAfull, BACfull, BIIBfull, BKfull, BKNGfull, BLKfull, BMYfull, Cfull, CATfull, CELGfull, CHTRfull, CLfull, CMCSAfull, COFfull, COPfull, COSTfull, CSCOfull, CVSfull, CVXfull, DDfull, DHRfull, DISfull, DOWfull, DUKfull, EMRfull, EXCfull, Ffull, FBfull, FDXfull, GDfull, GEfull, GILDfull, GMfull, GOOGfull, GOOGLfull, GSfull, HDfull, HONfull, IBMfull, INTCfull, JNJfull, JPMfull, KHCfull, KMIfull, KOfull, LLYfull, LMTfull, LOWfull, MAfull, MCDfull, MDLZfull, MDTfull, METfull, MMMfull, MOfull, MRKfull, MSfull, MSFTfull, NEEfull, NFLXfull, NKEfull, NVDAfull, ORCLfull, OXYfull, PEPfull, PFEfull, PGfull, PMfull, PYPLfull, QCOMfull, RTNfull, SBUXfull, SLBfull, SOfull, SPGfull, Tfull, TGTfull, TXNfull, UNHfull, UNPfull, UPSfull, USBfull, UTXfull, Vfull, VZfull, WBAfull, WFCfull, WMTfull, XOMfull)


# Explore % change by stock (Min, Max, Avg) vs stock volatility



# Pivot-table - I wanted to explore a summarized table by stock of key metrics 
SnPSummary <- group_by(SnP100full, SnP100full$Symbol)

SnPSummary = summarise(SnPSummary, 
                        avg_vlty = mean(Volatility),
                        min_vlty = min(Volatility),
                        max_vlty = max(Volatility),
                        avg_ON_ppc = mean(ON_PPC),
                        min_On_ppc = min(ON_PPC),
                        max_on_ppc = max(ON_PPC),
                        avg_HL_ppc = mean(HLppc),
                        min_HL_ppc = min(HLppc),
                        max_HL_ppc = max(HLppc))

##All section beyond this points are in Rattle

install.packages("rattle")
install.packages("rattle", dependencies=c("Depends", "Suggests"))

library(rattle)

rattle()



# Rattle file "SnP100full.rattlev3" could be opened from Rattle screen

# Also please refer to log (pdf) for tracking of key modeling & validation work
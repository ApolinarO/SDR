setwd("/home/tony/WMU/SDR/Spikes/XPT_converter_Spike")

#  Instructions  #
#  Have directory set to location of Xpt data  #
#  Insure Hmisc package is installed and loaded  #
#  Input a is the name of the Xpt file without the extension  #
#  Input b is the name you want to give to the csv  #
#  Input c in location of folder you wish to put the created csv  #
#  Input c is optional with default location set to the currect working directory  #
#  Quotes are needed for all inputs  #

library(Hmisc)
library(SASxport)
XpttoCsv.func <- function(a,b,c=NULL){
  print('hello')
  xpt.name <- paste(a,".XPT",sep="")
  csv.name <- paste(c,b,".csv",sep="")
  print('about to process my data')
  dat <- sasxport.get(xpt.name)
  print('got my data')
  write.csv(dat[,-1],file=csv.name,row.names = FALSE)
  }

# Example with location specified  #
XpttoCsv.func("MGX_H","test4","/home/tony/WMU/SDR/Spikes/XPT_converter_Spike/")

# Example without location specified  #
XpttoCsv.func("DEMO_H","test4")

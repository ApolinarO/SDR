getwd()
setwd("C:/Users/skill/Desktop/NHANES")

#  Instructions  #
#  Have directory set to location of Xpt data  #
#  Insure Hmisc package is installed and loaded  #
#  Input a is the name of the Xpt file without the extension  #
#  Input b is the name you want to give to the csv  #
#  Input c in location of folder you wish to put the created csv  #
#  Input c is optional with default location set to the currect working directory  #
#  Quotes are needed for all inputs  #


library(Hmisc)
XpttoCsv.func <- function(a,b,c=NULL){
  xpt.name <- paste(a,".XPT",sep="")
  csv.name <- paste(c,b,".csv",sep="")
  dat <- sasxport.get(xpt.name)
  write.csv(dat[,-1],file=csv.name,row.names = FALSE)
  }

# Example with location specified  #
XpttoCsv.func("DEMO_H","test4","C:/Users/skill/Desktop/Test/")

# Example without location specified  #
XpttoCsv.func("DEMO_H","test4")

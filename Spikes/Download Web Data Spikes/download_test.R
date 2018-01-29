source("download.R")
library("RUnit")

#checkEuals()
#checkException()
test.tokenizeString <-function(){
  checkEquals("this_works_", tokenizeString("this/works\\"))       # Replace '\', '/' with '_'
  checkEquals("this&works", tokenizeString("this&amp;works"))      # Replace "&amp;" with '&'
  checkEquals("this&works__", tokenizeString("this&amp;works\\/")) # Replace both
}

test.formatRowData <-function(){
  checkException(formatRowData(c("1", "2", "3"), 1)) # Too few in arguments
  
  res = formatRowData(c("2001-2020", "The Data Name", "<a href=\"as.XPT\">something</a>", "<a href=\"as2.XPT\">something else</a>"), 1)
  checkEquals("https://wwwn.cdc.gov/as2.XPT", res["Download Link"])
  #checkTrue(res["Download Link"] != "as2.XPT", "Test failed")
  #checkEquals("", )
  
}
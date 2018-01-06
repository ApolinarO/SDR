# Developer: Apolinar Ortega
# About: The purpose of this spike is to get data from an online API. From there, it will turn XML or JSON into an R data frame

library("XML")
library("methods")
# XML Spike:
  # Calls a web API and converts the resulting XML into a data frame
xmlSpike = function()
{
  
  # Query string for web api
  url = "https://www.sbir.gov/api/awards.xml?keyword=cbinsights"
  #url = "https://chronicdata.cdc.gov/api/views/5svk-8bnq/rows.xml"
  
  # Calls the web API, turns it into an XML data type, and then creates a data frame
  page = readLines(url)
  pageXML = xmlParse(page)
  pageFrame = xmlToDataFrame(pageXML)
  
  # Prints results
  xmlCount = length(pageFrame[,1])
  #print(pageXML)
  print(sprintf("names(pageFrame): %s", paste(collapse=" ",names(pageFrame)) ))
  print(paste0("Results: ", xmlCount))
  print(paste0(names(pageFrame)[1], ":"))
  print(paste0(" ", pageFrame[,1]))
}

# Simple XML function that takes in a keyword, queries the web API with it,and 
  # outputs the resulting XML
xml = function(keyword)
{
  url = sprintf("https://www.sbir.gov/api/awards.xml?keyword=%s", keyword)
  print(url)
  page = readLines(url)
  pageXML=xmlParse(page)
  
  return (pageXML)
}

# JSON Spike: 
  # Calls a web API and converts the resulting JSON into a data frame
jsonSpike()
{
  library("jsonlite")
  url = "https://chronicdata.cdc.gov/api/views/5svk-8bnq/"
  
  # Calls the web api and then turns it into an R object
  page = readLines(url)
  pageJS = fromJSON(page)
  
  ##pageJS$tags
  pageJS$columns
}

xmlSpike()
xml("cbinsights")
jsonSpike()

xmlSpike = function()
{
  library("XML")
  library("methods")
  #url = "https://www.sbir.gov/api/awards.xml?keyword=cbinsights"
  url = "https://chronicdata.cdc.gov/api/views/5svk-8bnq/rows.xml"
  # Reads into a string
  page = readLines(url)
  
  # Parses into xml
  pageXML=xmlParse(page)
  #print(pageXML)
  
  # Turns it into data frame
  pageFrame = xmlToDataFrame(pageXML)
  xmlCount = length(pageFrame[,1])
  for(item in pageFrame[,1])
    print(item[1])
}

xml = function(keyword)
{
  url = sprintf("https://www.sbir.gov/api/awards.xml?keyword=%s", keyword)
  print(url)
  page = readLines(url)
  pageXML=xmlParse(page)
  
  return (pageXML)
}

#xml("cbinsights")

library("jsonlite")
url = "https://chronicdata.cdc.gov/api/views/5svk-8bnq/"
page = readLines(url)
pageJS = fromJSON(page)
#pageJS$tags
pageJS$columns


# https://demo.ckan.org/api/3/action/package_show?id=adur_district_spending
# https://catalog.data.gov/dataset/national-health-and-nutrition-examination-survey-nhanes

# For every datat set, there are required fields
  # Title, Description, Tags, Last Update, Publisher, Contact Name, etc.
# A collection counts as 1 dataset in total



# OTHER PACKAGES
  # https://www.rstudio.com/products/rpackages/
  # plumber <web API>, rshiny<web interface>, ggplot, test that, roxygen2 <documentation>, stringr, markdown

# PUBLISH APPS
  # ApolinarO.shinyapps.io
  # library(rsconnect)
  # rsconnect::deployApp('path/to/your/app')
  # Make sure console is in currrent directory
  # getwd(), setwd(dir)
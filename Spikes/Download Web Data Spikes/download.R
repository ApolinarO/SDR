# Other NHANES API?
  # https://github.com/chiragjp/nhanes_scidata
  # https://pic-sure.org/products/nhanes-unified-dataset
# NHANES List
  # https://www.cdc.gov/nchs/nhanes/nhanes_listserv.htm


# SrapeR Attampt
library("XML")
library("scrapeR")
  # https://cran.r-project.org/web/packages/scrapeR/scrapeR.pdf

# Get HTML Page
list.url = "https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx"
page.source = scrape(url=list.url, parse=F)

# Parse document
doc.html = htmlParse(page.source, asText=T)
doc.root = xmlRoot(doc.html)
doc.body = xmlChildren(xmlChildren(doc.root)$body[4])

doc.body.div = doc.body$div
temp = doc.body.div[5]
temp2 = temp$form


# Using Regular Expressions
library(stringr)
#grep("^\\w", c("asd", "#_##", "asp"), value=T)

test.string = "<div><table>success</table></div>"
str_extract(test.string, "<table.*>(.*)</table>")
#grep("(<table)", test.string)

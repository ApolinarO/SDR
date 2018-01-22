# Other NHANES API?
  # https://github.com/chiragjp/nhanes_scidata
  # https://pic-sure.org/products/nhanes-unified-dataset
# NHANES List
  # https://www.cdc.gov/nchs/nhanes/nhanes_listserv.htm


# SrapeR Attampt
library("XML")
library("stringr")
library("scrapeR")
  # https://cran.r-project.org/web/packages/scrapeR/scrapeR.pdf

# Get HTML Page
list.url = "https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx"
page.source = scrape(url=list.url, parse=F)
source.string = gsub("[\r\n\t]", "", toString(page.source))

# Captures tables and then rows from it
source.table = str_match(source.string, "<table[^>]+>(.+?)</table>")[1,2]
source.table.rows = str_match_all(source.table, "<tr>(.+?)</tr>")[[1]]

row.data = str_match_all(rows, "<td.+?>(.+?)</td>")

# Transform into a 2d array
the.data = array(dim=c(length(row.data),6))
for(i in 1:length(row.data))
{
  item = row.data[[i]][,2]
  link1 = link = str_match(item[3], "<a href=\"(.+?)\">(.+?)</a>")[,2:3]
  link2 = link = str_match(item[4], "<a href=\"(.+?)\">(.+?)</a>")[,2:3]
  the.data[i,] = c(item[1:2], link1, link2)
}


#download.file("https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/ACQ.XPT", "testDownload", "curl")
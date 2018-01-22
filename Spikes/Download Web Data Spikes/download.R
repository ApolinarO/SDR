# Other NHANES API?
  # https://github.com/chiragjp/nhanes_scidata
  # https://pic-sure.org/products/nhanes-unified-dataset

library("stringr")
library("scrapeR")

# HTML page -> string
page.source   = scrape(url="https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx", parse=F)
source.string = gsub("[\r\n\t]", "", toString(page.source))

# Uses Regular Expressions to get desired table data from the page
source.table      = str_match(source.string, "<table[^>]+>(.+?)</table>")[1,2]
source.table.rows = str_match_all(source.table, "<tr>(.+?)</tr>")[[1]]
row.data          = str_match_all(source.table.rows, "<td.+?>(.+?)</td>")

# Downloads data
for(i in 1:length(row.data))
{
  if(i %% 50 == 0)
    print(paste0(i, "/", length(row.data)))
  
  # Extracts desired data
  item = row.data[[i]][,2]
  item = c( item[1:2],                                             # Year & Data File Name
            str_match(item[3], "<a href=\"(.+?)\">(.+?)</a>")[,2], # Documentaiton Link
            str_match(item[4], "<a href=\"(.+?)\">(.+?)</a>")[,2]) # Data Link
  
  # Download data if link available
  if(!is.na(item[4])){
    download.file(url      = paste0("https://wwwn.cdc.gov/", item[4]),
                  destfile = paste0("data/", item[2], " [", item[1], "]"),
                  method   = "curl", quiet=T)
  }else{
    print(paste0(i, ": ", item[2], "[", item[1], "]", " was not selected"))
      }
}

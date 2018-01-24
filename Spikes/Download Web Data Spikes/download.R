library("stringr")
library("scrapeR")

downloadListPage <- function(download.url="https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx"){
  # Extracts an HTML page into a string
  #
  # Args: 
  # download.url: url of the list page to download
  #
  # Returns: the HTML page as a string
  
  page.source   = scrape(url=download.url, parse=F)
  source.string = gsub("[\r\n\t]", "", toString(page.source))
  return (source.string)
}

gatherRowDataFromList <- function(source.string){
  # Uses Regular Expressions to get desired table data from the page
  #
  # Args:
  #   source.string: a string that stores the entire HTML page
  #
  # Returns: an R object in which it contains the desired data from each row
  source.table      = str_match(source.string, "<table[^>]+>(.+?)</table>")[1,2]
  source.table.rows = str_match_all(source.table, "<tr>(.+?)</tr>")[[1]][,2]
  row.data          = str_match_all(source.table.rows, "<td.+?>(.+?)</td>")
  
  for(i in 1:length(row.data))
    row.data[[i]] = formatRowData(row.data[[i]][,2], i)
  
  return(row.data)
}

formatRowData <- function(row.item, index){
  # Formats a row into an easy to read an interpret string
  #
  # Args:
  #   row.item: data that was found within the <td> tags
  #   index: the position of the row item
  #
  # Returns: a vector containing the year(s), data name, documentation link, and download link
  data.name = tokenizeString(row.item[2])
  
  item = c(
    "Year(s)" = row.item[1],
    "Name"    = data.name,
    "Documentation Link" = str_match(row.item[3], "<a href=\"(.+?)\">(.+?)</a>")[,2],
    "Download Link"      = str_match(row.item[4], "<a href=\"(.+?)\">(.+?)</a>")[,2],
    "File Name"= paste0(data.name, "[", row.item[1], "]"),
    "Index"    = index
    )
  
  if(!is.na(item[3]))
    item[3] = paste0("https://wwwn.cdc.gov/", item[3])
  if(!is.na(item[4]))
    item[4] = paste0("https://wwwn.cdc.gov/", item[4])
  
  return(item)
}

downloadData <- function(row.data){
  # Downloads data
  #
  # Args:
  #   row.data: lists the files to download along with additional information
  #
  # Returns: a log containing all the special cases (ie. no download file, not in XPT format)
  special.cases = c()
  #for(i in 1:length(row.data))
  for(item in row.data)
  {
    i = as.numeric(item["Index"])
    if(i%%10 == 0)
      print(paste0(i, "/", length(row.data)))
    print(paste0(i, ": ", item["File Name"]))
    
    # Download data if link available
    if(!is.na(str_match(item["Download Link"], ".*\\.XPT"))){     # Is .XPT, download
      download.file(url      = item["Download Link"],
                    destfile = paste0("./data/", item["File Name"]),
                    method   = "curl", quiet = T)
    } else if(is.na(item["Download Link"])){                      # Is NA, note it
      special.cases = c(special.cases, print(paste0(i, ": ", item["File Name"], " not selected")))
    }else{                                          # Isn't XPT, note as special case
      special.cases = c(special.cases, print(paste0("*", i, ": ", item["File Name"], "(", item["Download Link"], ")", " special case check manually")))
    }
  }
  # Note issue w/ [~415] 1999-2006 Duel Energy X-ray Absorptiometry - Whole Body
    # It has an irregular data set
  return(special.cases)
}

tokenizeString <- function(strings){
  # Sanitizes a string from HTML input into something appropriate for a file name
  #
  # Args:
  #   string: string to tokenize
  #
  # Returns: a sanitized string
  temp = gsub("[//\\]", "_", strings)
  temp = gsub("&amp;", "&", temp)
  return(temp)
  }

runDownload <- function(log.file="special cases.txt"){
  # Scrapes the NHANES list for data
  #
  # Args:
  #   log.file: file in which to log the special cases
  source.string <- downloadListPage()
  row.data <- gatherRowDataFromList(source.string)
  special.cases <- downloadData(row.data)
  
  writeLines(special.cases, con=log.file, sep="\n")
  }
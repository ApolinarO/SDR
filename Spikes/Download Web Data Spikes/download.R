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
    "File Name"= paste0(data.name, "[", row.item[1], "].XPT"),
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
    if(!is.na(str_match(item["Download Link"], ".*\\.(?:XPT|xpt)"))){     # Is .XPT, download
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
  temp = gsub("[//\\,]", "_", strings)
  temp = gsub("&amp;", "&", temp)
  return(temp)
}

write.files <- function(special.cases, row.data, log.file, documentation.file, append.file=F){
  # Creates file for special cases and for linking documentation to file
  #
  # Args:
  #  special.cases: special cases
  #  row.data: row data
  #  log.file: file storing the special cases
  #  documentation.file: file linking other files to documentation
  write(special.cases, file=log.file, sep="\n", append=append.file)
  
  # Documentation Links
  var <-c()
  for(item in row.data)
    var <- c(var, paste0(item["File Name"], ",", item["Documentation Link"]))
  write(var, file=documentation.file, sep="\n", append=append.file)
}

RunChecks <- function(){
  # To be run before the downloads are run. This checks to make sure that user is in the right directory and that /data exists.
  
  # Check if in parent directory
  parent.dirs = tail(unlist(strsplit(getwd(), "/")), 3)
  if(any(parent.dirs != c("SDR", "Spikes", "Download Web Data Spikes"))){
    print("ERROR! You are not running this under '/SDR/Spikes/Download Web Data Spikes'!")
    stop()
  }
  
  # Create /data if it doesn't already exist
  if(!dir.exists(file.path(getwd(), "data"))){
    print("'/data' directory created for you")
    dir.create("data")
  }
}
  
runDownload <- function(log.file="special cases.txt", documentation.file="documentation links.txt"){
  # Scrapes the NHANES list for data
  #
  # Args:
  #   log.file: file in which to log the special cases
  #   documentation.file: file in which to link file names and the documentation
  source.string <- downloadListPage()
  row.data <- gatherRowDataFromList(source.string)
  special.cases <- downloadData(row.data)
  write.files(special.cases, row.data, log.file, documentation.file, T)
}

# Runs the download on the missing data
runDownload2 <-function(url="https://wwwn.cdc.gov/Nchs/Nhanes/Dxa/Dxa.aspx", log.file="special cases.txt", documentation.file="documentation links.txt"){
  # Scrapes data for a specific item
  #
  # Args:
  #   url: where this data is located at
  #   log.file: file in which to log the special cases
  #   documentation.file: file in which to link file names and the documentation
  source.string <- downloadListPage(url)
  
  # Gets desired row data
  data.items <- str_match_all(source.string, "<h4>([\\d-]+)</h4>(.+?</ul>)")
  data.items <- data.items[[1]][,2:3]
  row.data = str_match_all(data.items[,2], "<li>(.+?)</li>")
  
  # Formats row data
  for(i in 1:length(row.data)){
    item = c(
      "Year(s)" = data.items[i,1],
      "Name"    = "Dual-Energy X-ray Absorptiometry - Whole Body (Multiply Imputed Data)",
      "Documentation Link" = str_match(row.data[[i]][2,2], "<a href=\"(.+?)\">(.+?)</a>")[,2],
      "Download Link"      = str_match(row.data[[i]][1,2], "<a href=\"(.+?)\">(.+?)</a>")[,2],
      "File Name"= "",
      "Index"    = i
    )
    item["File Name"] = paste0(item["Name"], "[", item["Year(s)"], "].XPT")
    item["Download Link"] = paste0("https://wwwn.cdc.gov/Nchs/", str_match(item["Download Link"], "(data|nhanes).+")[1])
    item["Documentation Link"] = paste0("https://wwwn.cdc.gov/Nchs/", str_match(item["Documentation Link"], "(data|nhanes).+")[1])
    
    row.data[[i]] = item
  }
  
  special.cases <- downloadData(row.data)
  write.files(special.cases, row.data, log.file, documentation.file, T)
}

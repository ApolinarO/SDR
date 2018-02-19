source("download.R")
library("stringr")
library("RUnit")


test.downloadListPage <-function(){
	checkEquals("", downloadListPage("asasd"))
	checkTrue(""!=downloadListPage("https://www.w3schools.com/"))
}

test.formatRowData <-function(){
  # Too Few Rows
  checkException(formatRowData(c("1", "2", "3"), 1))

  # Test Case
  res <- formatRowData(c("2001-2020", "The Data Name", "Not A Document Link", "<a href=\"as2.XPT\">something else</a>"), 1)
  checkEquals("2001-2020", res["Year(s)"], checkNames=F)
  checkEquals("The Data Name", res["Name"], checkNames=F)
  checkTrue(is.na(res["Documentation Link"]), "re['Documentation Link'] Test failed")
  checkEquals("https://wwwn.cdc.gov/as2.XPT", res["Download Link"], checkNames=F)
  checkEquals("The Data Name[2001-2020].XPT", res["File Name"], checkNames=F)
  checkEquals("1", res["Index"], checkNames=F)
}

test.tokenizeString <-function(){
  # '\' and '/' to '_'; and '&amp;' to '&'
  checkEquals("this_works_", tokenizeString("this/works\\"))       # Replace '\', '/' with '_'
  checkEquals("this&works", tokenizeString("this&amp;works"))      # Replace "&amp;" with '&'
  checkEquals("this_works", tokenizeString("this,works"))      # Replace "," with '_'
  checkEquals("_this&works__", tokenizeString(",this&amp;works\\/")) # Replace all three
}

# Tests if any changes have been made since the program was last updated
test.changes <-function(){
	source.string <- downloadListPage()
	checkTrue(source.string!="", msg="Error finding the List Page URL. Perhaps it changed?")

	row.data <- gatherRowDataFromList(source.string)
	checkTrue(length(row.data) == 1225, msg="The data page has been modified to either include more data or less data.")
}

# Makes sure that the user is in /SDR/Spikes/Download Web Data
#no.test.inDesiredDirectory <-function(){
  # Gets the 1st 3 parent directories in the path
#  curr.dir = getwd()
#  dir.heirarchy = str_match_all(curr.dir, "[\\/][\\w\\s]+")[[1]][,1]
#  dir.heirarchy = tail(dir.heirarchy, 3)
  
  # Makes sure the path matches
#  errmsg="You are not in the current directory. Make sure you are in /SDR/Spikes/Download Web Data Spikes"
#  checkTrue(dir.heirarchy[3] == "/Download Web Data Spikes", msg=errmsg)
#  checkTrue(dir.heirarchy[2] == "/Spikes", msg=errmsg)
#  checkTrue(dir.heirarchy[1] == "/SDR", msg=errmsg)
#}

#makes sure that ./Data exists before running
#no.test.dataDirectoryExists <-function(){
#  files = list.files(".", all.files=F, full.names=F)
#  files = gsub("\\.\\w+", "", files)
#  checkTrue(any(files=="data"), msg="Folder \"data\" not present. Create the folder within the current directory.")
#}


#test.gatherRowDataFromList <-function(){}
#test.downloadData <-function(){}

# TO DO
	# Download Remaining Files

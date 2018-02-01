# Download Web Data Spike
This Spike is meant to prove that it is possible to automate the download of the entire NHANES data set. This project works mainly through the use of regular expressions.

## User Guide

To run the program as of now, the user must run it through the bash terminal.

1. On the terminal, cd into this application's directory

2. Run tests by entering the following into the terminal

	make

3. If a folder called _/data_ does not exist alongside this project, then make the directory.

	mkdir data

4. Run the main program. Note that this may take a while. Enter the following:

	make run

5. Once the tests have run, you will now have to deal with the special cases. A log file under the name of _special cases.txt_ contains a list of which data sets could not be downloaded.

    - In this step, get a list of all the lines marked with a _*_ at the beginning. Those you will have to download by hand. The data for them can be found [here](https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx).
    - When downloading the data, make sure to add it into the _/data_ folder and to have it in the XPT format.
    - Finally, look into the _documentation links.txt_ file. For each file added to _/data_, add a line containing the file name and the link to the documentation. It should look like the following:

	file name[year1-year2].ZPT,url

    - In this step, ignore the  _Dual-Energy X-ray Absorptiometry - Whole Body_ data set.


# About the program

## RDC Only

You may have noticed that if you follow the NHANES link that some files are listed as "RDC Only". This is data protected by the Research Data Center. More information [here](https://www.cdc.gov/rdc/).

## Step 1: Extract data listings

The program starts by looking at a page that lists all of the [data download links for NHANES](https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx).

The program starts by downloading a web page and then converting it into a string, which is accomplished through the code below:

	page.source   = scrape(url="https://wwwn.cdc.gov/nchs/nhanes/search/datapage.aspx", parse=F)
	source.string = gsub("[\r\n\t]", "", toString(page.source))


The following lines then performs a series of operations which eventually extracts the row data from the desired table

	source.table      = str_match(source.string, "<table[^>]+>(.+?)</table>")[1,2]
	source.table.rows = str_match_all(source.table, "<tr>(.+?)</tr>")[[1]]
	row.data          = str_match_all(source.table.rows, "<td.+?>(.+?)</td>")

## Step 2: Download the data

Now that the program has the data listings, it then iterates through each item in _row.data_ as seen below:

	item = row.data[[i]][,2]

From the selected data, we extract the year, data name, the documentation link, and the data file link: 

	item = c( item[1:2],                                             # Year & Data File Name
            str_match(item[3], "<a href=\"(.+?)\">(.+?)</a>")[,2], # Documentaiton Link
            str_match(item[4], "<a href=\"(.+?)\">(.+?)</a>")[,2]) # Data Link

Finally, we download the data:

	download.file(url      = paste0("https://wwwn.cdc.gov/", item[4]),
                  destfile = paste0("data/", item[2], " [", item[1], "]"),
                  method   = "curl", quiet=T)

## Packages Required

### stringR
stringR is a simple package for the manipulation of strings. The functions _gsub_, _str\_match_, and _str\_match\_all_ are all defined within it.

#### Resources
- [Learn Regular Expressions](https://regexone.com/)
- [Tests Regular Expressions](https://regexr.com/)

### scrapeR
scrapeR provides the _scrape_ function, which downloads an HTML page that can then be parsed into an R object. The documentation for it can be found [here](https://cran.r-project.org/web/packages/scrapeR/scrapeR.pdf).
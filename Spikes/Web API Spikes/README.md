# Get Web Info Spike
This application is meant to test how R interacts with web API's. This tests for API's that returns data encoded in either JSON or XML.

The following makes a simple call to the API: 

    page = readLines(url)
    
## XML
The libraries needed to do this spike can be installed and loaded under the names of "XML" and  "methods"
Here is code that makes a call to a web API, parses the page into XML, and then turns it into an R data frame: 

    url = "https://www.sbir.gov/api/awards.xml?keyword=cbinsights"
    page = readLines(url)
    pageXML = xmlParse(page)
    pageFrame = xmlToDataFrame(pageXML)

## JSON
The Library to import here is called "jsonlite".
The process to get a JSON file is similar to that with XML. The page is read and then turned into a data frame. The code below does just that: 

    url = "https://chronicdata.cdc.gov/api/views/5svk-8bnq/"
    page = readLines(url)
    pageJS = fromJSON(page)

## Resources
 - [API used in JSON example](https://demo.ckan.org/api/3/action/package_show?id=adur_district_spending)
 - [API used in XML example](https://www.sbir.gov/api/)

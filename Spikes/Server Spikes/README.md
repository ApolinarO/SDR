# Server Spikes

The purpose of this spike is to learn about what server options we have for hosting the application and the data in the short term and the long term. Most of this will be looking at the free options.

# TO DO
Look At
	- Amazon Web Services

Test
	- Shiny Server on Mac
	- Shiny Server on Ubuntu machine
	- Test Data Access Application
		- Tests whether or not accessing NHANES would require a large instance Size
	- Implementing a remote server


## RStudio Connect

R Studio Connect is a publishing platform. It also includes R Shiny.

This is not to be confused with the _rsconnect_ library allows for the publishing of R Shiny or to RStudio Connect.

## Shiny Server

It allows the hosting of Shiny Applications on a custom server.

- It's software is built for Ubuntu 12.04 or higher, Redhat/CentOS 6 or 7, or SLES 11 or higher	
	- It can run on other Linux platforms but it must be compiled from source
	- It cannot run on any Mac OS or Windows OS.
	- This source claims to have have [Shiny Server on Mac](https://github.com/talonsensei/codex-python/wiki/Howto-Install-Shiny-Server-on-OSX).
	- This source claims to have [Shiny Server on Windows](https://github.com/leondutoit/shiny-server-on-ubuntu). However, this requires creating a Linux VM.


## ShinyApps.io

This is looking at the free version and it's capabilities:

- Allows for 5 applications
	- Can be unlimmited with a payment plan
- Allows for 25 active hours per month
	- Can be up to 10,000 hourse per month with payment plan
- Applications are branded with RStudio logo
- Maximum Instance Size: 1 GB
	- Can be up to 8 GB with a payment plan
 - Maximum Storage: 1 GB
 	- Can be up to 5 GB with a payment plan


## Conclusion

If we go with a Shiny Server, it's suggested that we use the free version. Looking at [this checlist](https://support.rstudio.com/hc/en-us/articles/217240558-What-is-the-difference-between-shinyapps-io-and-Shiny-Server-Pro-), getting the pro version of Shiny Server is not really worth it.

Currently, our application needs about **NHANES-size** GB of storage for the entire NHANES data set. A worst case scenario would be a 4GB-szed application. For Normal Instances, 1GB might be enough considering that the largest files are up to 100MB.

For long-term storage, shinyapps.io is not suggested. It can be suitable for testing a portion of the data set.



## Further Readings/ References

### Shiny Server
- [Should we get shiny server?](https://support.rstudio.com/hc/en-us/articles/217240558-What-is-the-difference-between-shinyapps-io-and-Shiny-Server-Pro-)
- [Comarison of ShinyApps.io, Shiny Server, and Shiny Server Pro](https://www.rstudio.com/products/shinyapps/)
- [Comarison of ShinyApps.io, Shiny Server, Shiny Server Pro, and RStudio Connect](https://www.rstudio.com/products/shiny/shiny-server/)
- [Platforms Supported](https://www.rstudio.com/products/shiny/download-server/)

### RStudio Connect
- [Main Page](https://www.rstudio.com/products/connect/)

### ShinyApps.io
- [Main Page](http://www.shinyapps.io/)
- [Documentation](http://docs.rstudio.com/shinyapps.io/)
- [App Maximum Size](https://support.rstudio.com/hc/en-us/articles/219449487--How-much-data-can-I-upload-to-shinyapps-io-)

### Amazon Web Services

### WMU Linux Server


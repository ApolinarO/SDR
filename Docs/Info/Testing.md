# R Data Project - Testing
This project utilizes both unit tests and functional tests. Alongside these tests, the project will be given to our client to perfrorm usability tests.

## Unit Testing: _RUnit_
RUnit is a simple unit testing framework for R. Assertions are called checks instead and the code to run the assertions must be located within a separate file.

First, the checks/assertions are written. Here is some sample code below that checks if a concatenation is correct:

	test.concatentation <- function(){
		half <- paste0("1", "/2")
		checkEquals(half, "1/2")
	}

The test is then put into a test suite. Here is a sample call to define a suite:

	t.suite = defineTestSuite(name, dir, testFileRegexp, testFuncRegexp)

In this call, a test suite is stored into variable _t.suite_. _name_ is what the test suite is called, _dir_ is the directory in which the test files are located in, _testFileRegexp_ denotes which test files to look for in the directory(s), and testFuncRegexp says which test functions to look for in the test files.

The following calls runs the suite and prints the test results

	t.results = runTestSuite(t.suite)
	printTextProtocol(t.results)

### Further Reference
 - We have an [RUnit Spike](../Spikes/RUnit%20Spikes) that demonstrates the framework.
 - For more information on how to use RUnit, [use the source provided through CRAN](https://cran.r-project.org/web/packages/RUnit/vignettes/RUnit.pdf).
 - For more information on the RUnit function calls, check out [this](https://cran.r-project.org/web/packages/RUnit/RUnit.pdf) source.
 - [R Shiny Gallery](https://shiny.rstudio.com/gallery/genome-browser.html)

 
## Function Testing: _Sylenium_
Sylenium allows us to automatically test the interface of the RShiny application.
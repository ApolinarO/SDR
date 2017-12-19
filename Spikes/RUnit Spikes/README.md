# RUnit Spike(s)
## Developer(s)
 - Apolinar Ortega

## About
This spike is meant to test the functionalities of the RUnit framework. The RUnit framework is a simple unit testing framework for the R langauge.

## How To Run This
Make sure that your current working directory is the same as this README. Also make sure to install the *pracma* and *RUnit* packages.

To run the tests, run the file titled *prog_test_run.R*.

## About The Files
##### prog.R
This file contains the *frac.to.string()* fucntion which will be tested.

##### prog_test.R
This file contains the RUnit tests to run. Note that all of the test names starts with a "test.". This is done so that when the tests are run, they can be found.

##### prog_test_run.R
This file contains the code to run the RUnit tests. It first finds the test file(s) and then the test functions(s) within those files.

## About RUnit
RUnit works by having at least 2 different files. The first file, *prog_test.R* contains the RUnit tests to run. The second file, *prog_test_run.R*, contains code to find and run the RUnit tests.

#### RUnit in *prog_test.R*
##### checkEquals(x, y)
This function call perfroms an assertion that tests whether or not the value of x matches the value of y. Below is a sample call:

    fracs <- fraction.to.string(1, 2)
    checkEquals(fracs, "1/2")
This unit test passes. However, the following is meant to fail:

    fracs <- fraction.to.string(1, 2)
    checkEquals(fracs, "1/3")

##### checkException(expr)
This function call checks to make sure that an exception occurred.

In our *fraction.to.string(num, den)* function call, the parameters *num* and *den* are expected to be numbers so that arithmetic can be applied to them. The following call should throw an exception:

    fraction.to.string("1", "2")
Therefore, the following test is silent when it runs:

    checkException(fraction.to.string("1", "2"))
An failed run is as followed:

    checkException(fraction.to.string(1, 2))
    
#### RUnit in *prog_test_run.R*
##### defineTestSuite(name, dir, testFileRegexp, TestFuncRegexp)
This call builds a test suite that will run the RUnit tests. *name* is the name of the test suite, *dir* contains the directories to find the test files in, *testFileRegexp* says which test files to look for in the directory(s), and *TestFuncRegexp* says what are the test functions within the test file(s).

The following call 

    t.suite = defineTestSuite("frac.to.string", ".", testFileRegexp = ".+_test.R$", testFuncRegexp = "^test.+")
Creates a test suite called "frac.to.string". It specifies that the test files to look for are in the current directory. It also tells it that the test files ends with a "test.R" and the test functions begins with a "test".

The following runs the tests:

    t.results = runTestSuite(t.suite)
The following prints the test results: 

    printTextProtocol(t.results)

## Further Reference
 - For more information on how to use RUnit, [use the source provided through CRAN](https://cran.r-project.org/web/packages/RUnit/vignettes/RUnit.pdf).
 - For more information on the RUnit function calls, check out [this](https://cran.r-project.org/web/packages/RUnit/RUnit.pdf) source.
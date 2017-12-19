# Runs the tests suite

t.suite = defineTestSuite("frac.to.string", ".",
                          testFileRegexp = ".+_test.R$", 
                          testFuncRegexp = "^test.+")
if(!isValidTestSuite(t.suite)){
  print("Invalid test suite created!")
}
t.results = runTestSuite(t.suite)
printTextProtocol(t.results)

#runTestFile("prog.R")
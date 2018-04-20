app <- ShinyDriver$new("../")
app$snapshotInit("test_download")

app$uploadFile(file = "TRIGLY_G.csv")
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(dataName = "demo")
app$setInputs(dataName = "demo.")
app$setInputs(dataName = "demo")
app$snapshot()

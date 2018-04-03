app <- ShinyDriver$new("../")
app$snapshotInit("test_browse_csv")

app$uploadFile(file = "TRIGLY_G.csv") # <-- This should be the path to the file, relative to the app's tests/ directory
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$snapshot()

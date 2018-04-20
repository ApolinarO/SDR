app <- ShinyDriver$new("../")
app$snapshotInit("test_row_selection")

app$uploadFile(file = "TRIGLY_G.csv")
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(rows = c(681, 1491))
app$setInputs(rows = c(681, 1021))
app$snapshot()

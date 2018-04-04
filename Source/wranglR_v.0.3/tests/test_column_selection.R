app <- ShinyDriver$new("../")
app$snapshotInit("test_column_selection")

app$uploadFile(file = "TRIGLY_G.csv")
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(columns = "X")
app$setInputs(columns = c("X", "seqn"))
app$setInputs(updateButton = "click")
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$snapshot()

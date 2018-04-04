app <- ShinyDriver$new("../")
app$snapshotInit("mytest1")

# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$setInputs(cyl = "4")
# Input 'table_rows_current' was set, but doesn't have an input binding.
# Input 'table_rows_all' was set, but doesn't have an input binding.
app$snapshot()

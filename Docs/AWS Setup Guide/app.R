# Use runApp(".") to run the file

library("shiny")
# Defines UI for the App
ui = fluidPage("Hello World 8")

# Defines server Logic
server = function(input, output){}

# Creates Shiny App
shinyApp(ui=ui, server=server)

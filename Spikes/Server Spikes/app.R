library("shiny")

# Defines UI for the App
ui = fluidPage("Hello World")

# Defines server Logic
server = function(input, output){}

# Creates Shiny App
options(shiny.port=7775, shiny.host="10.80.211.119")
shinyApp(ui=ui, server=server)
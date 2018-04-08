library("shiny")
# Defines UI for the App
ui = fluidPage(paste0("Hello World 8", paste(Sys.info()), collapse=T))

# Defines server Logic
server = function(input, output){}

# Creates Shiny App
shinyApp(ui=ui, server=server)

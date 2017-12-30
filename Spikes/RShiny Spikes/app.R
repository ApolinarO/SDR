# Apolinar Ortega
  # The purpose of this app was to develop a basic R Shiny app that can be uploaded to a server 
  # Hosted at 

library("shiny")

# Simply displays "Hello World"
hello.page = function()
{
  # Defines UI for the App
  ui = fluidPage("Hello World")
  
  # Defines server Logic
  server = function(input, output){}
  
  # Creates Shiny App
  shinyApp(ui=ui, server=server)
}

# Displays a slider and a histogram
  # The slider affect the histogram's appearrance
slider.and.histogram.page = function()
{
  ui  = fluidPage(
    sliderInput(inputId="num", label="choose a number", value=25, min=1, max=100),
    plotOutput("hist")
  )
  
  server = function(input, output){
    output$hist = renderPlot({
      title = paste0(input$num, " Random Numbers")
      hist(rnorm(input$num), main=title)
    })
  }
  shinyApp(ui=ui, server=server)
}

#hello.page()
#slider.and.histogram.page()
runExample("01_hello")


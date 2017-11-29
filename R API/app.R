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

hello.page.2 = function()
{
  ui = fluidPage("Hello World")
  
  server = function(input, output){}
  
  shinyApp(ui=ui, server=server)
}

#hello.page()
slider.and.histogram.page()
#runExample("01_hello")


# NOTES
# http://shiny.rstudio.com/
# http://shiny.rstudio.com/tutorial/
# Tutorial 3 parts: build Shiny app, customize reactions, customize appearance
  # Shiny app is a delivery vehicle for R code
    # App is an open R session
    # When the web page changes, it reruns the R script
    # For now, runs on your computer
      # Can have a web server service the App, where anyone can acccess it through the cloud
    # Need to make a UI
      # UI is in HTML; is generated from R
      # fluidPage() generates HTML from R Code (stores as a string)
    # Need a set of R instructions
  # Use the template to add things to the app
  # Build apps around inputs and outputs
    # simply add inputs w/ input functions in the UI
      # Same w/ output functions
      # both generates HTML code
  # Input
    # buttons, checkboxes, checkboxes, radio button, date input, date range, file input, numeric input, password input, select box, sliders, text input
    # each input has an inputID to uniquely identify it
    # inputs take a label; label="" for no input
  # Output
    # dataTable, html, omage, plot, table, text, ui
    # each output has a unique outputId
    # output simply adds in the space in the UI for the output function
      # server must define how it behaves
  # Server function rules: 
    # Save object to display in output$
      # plotOutput("hist") => output$hist
    # build objects w/ a render function
      # Different render objects for different types of renders
        # render function contains type of object to build and a code block that renders that object
    # Use input values w/ input$
      # sliderInput(inputId="num") => input$num
  # Whenever an input$ changes, the output will be automatically updated
  # Share apps
    # replace the app w/ one that serves it on the cloud
    # app must be in the same directory as any dependencies (ie. images, data sets)
    # name app as app.R
    # can place app in 2 files: named ui.R and server.R
    # shinyApps.io is free to use and easy to use
  # Can run the app in a viware pane

# Objective: create app that cobines data frames and selects columns and names
  # select data frames to add
  # then add columns from those data frames
  # colBind(data frames)
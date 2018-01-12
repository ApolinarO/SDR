# Apolinar Ortega
  # The purpose of this app was to develop a basic R Shiny app that can be uploaded to a server 
  # Hosted at 

library("shiny")

# Test 1
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

# Test 2
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

# Test 3
  # Allows some parts of the code to not be updated
slider.and.histogram.page.2 = function()
{
  ui  = fluidPage(
    sliderInput(
      inputId="num", 
      label="choose a number", 
      value=25, min=1, max=100),
    textInput(
      inputId="title",
      label="Title: ",
      value="Histogram of Random Normal Values"),
    plotOutput("hist")
  )
  
  server = function(input, output){
    output$hist = renderPlot({
      hist(
        rnorm(input$num),
        
        # Object does not respond to any reactive value in the code
         main=isolate({input$title}))
    })
  }
  shinyApp(ui=ui, server=server)
}

# Test 3
  # Allows for the storing of variables on the server side
slider.and.histogram.page.3 = function()
{
  ui  = fluidPage(
    sliderInput(
      inputId="num", 
      label="choose a number", 
      value=25, min=1, max=100),
    plotOutput("hist"),
    verbatimTextOutput("stats")
  )
  
  server = function(input, output){
    # Reactive builds a reactive object
      # Must be called like a function
      # Eliminates the use of calling rnorm() twice
    data = reactive({
      rnorm(input$num)
    })
    
    output$hist = renderPlot({
      hist(data())
    })
    output$stats = renderPrint({
      summary(data())
    })
  }
  shinyApp(ui=ui, server=server)
}

# Test 3
slider.and.histogram.page.4 = function()
{
  ui  = fluidPage(
    actionButton(
      inputId="clicks",
      label="Click Me"),
    verbatimTextOutput("stats")
  )
  
  server = function(input, output){
    # Observes action button click
      # App should notbe based on the button's clicks
      # Observes which reactive values invalidates the observer
    observeEvent(input$clicks, 
                 # This code is treated like isolated
                 {
                   print(as.numeric(input$clicks))
                   output$stats = renderPrint({
                     as.numeric(input$clicks)
                   })
                   })
    
    # Similar to observeEvent
      # Give single block of code to run
    #observe({print(input$clicks)})
  }
  shinyApp(ui=ui, server=server)
}

slider.and.histogram.page.5 = function()
{
  ui  = fluidPage(
    sliderInput(
      inputId="num", 
      label="choose a number", 
      value=25, min=1, max=100),
    actionButton(inputId="go",
                 label="update"),
    plotOutput("hist")
  )
  
  server = function(input, output){
    data <- eventReactive(input$go, {
      rnorm(input$num)
    })
    
    # Creates a list of reactive values to manipulate
    # data <- reactiveaValues(data = rnorm(100))
    output$hist <- renderPlot({
        hist(data())
      })
  }
  shinyApp(ui=ui, server=server)
}

slider.and.histogram.page.6 = function()
{
  ui  = fluidPage(
    actionButton(inputId="norm",
                 label="Normal"),
    actionButton(inputId="unif",
                 label="Uniform"),
    plotOutput("hist")
  )
  
  server = function(input, output){
    rv <- reactiveValues{data<-rnorm(100)}
    
    observeEvent(input$norm, {rv$data <- rnorm(100)})
    observeEvent(input$unif, {rv$data <- runif(100)})
    
    output$hist <- renderPlot({
      hist(rv$data)
    })
  }
  shinyApp(ui=ui, server=server)
}

#hello.page()
#slider.and.histogram.page()
slider.and.histogram.page.6()
#runExample("01_hello")

### NOTES ###
# When the app is started, it is private by default
# Can build your own server
  # Shiny Server: rstudio.com/products/shiny/shiny-server
  # Free, open source; made especially for Shiny Apps
# When sharing apps, can be in app.R or ui.R and server.R

# Look at shiny showcase

# Input object propogates to output objects
# Can have an input object trigger arbitrary code to run on the server side
# Can have inputs create objects that themselves can also be updated
  # ie. input creates multiple buttons

# Reactive values works w/ reactive functions
  # Acts as data streams that flows through the app
  # Can only call a reactive value from a function designed to work with one
  # Reactive values notifies downstream (invalidating)
    # The object created responds

# Reactive Toolkit
  # Takes a chunk of code to build and rebuild an object
  # Responds to changes from reactive values
# render*(): renderDataTable(), reanderPlot()
  # Takes code used to build and rebuild an object
  # The plotted code runs as a single unit
  # Results are always stored to output$*
# Reactive expressions makes an object to use

# Delay reactions
#
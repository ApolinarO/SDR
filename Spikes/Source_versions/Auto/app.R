library(shiny)
library(MASS)
library(ISLR)
install.packages("ISLR")
data <- Auto
View(data)
attach(data)

str(data)


summary(data)
max(data$year)


ui <- fluidPage(
  titlePanel("AUTO DATASET"),
  
  fluidRow(
    column(4,
           selectInput("model",
                       "Model:",
                       c("All",
                         unique(as.character(data$name))))
    ),
    
    column(4,
           selectInput("cyl",
                       "Cylinders:",
                       c("All",
                         unique(as.character(data$cylinders))))
    ),
    
    column(4,
           sliderInput("year", "Year:",
                       min = min(data$year), max = max(data$year),
                       value = 1, step = 1,
                       animate =
                         animationOptions(interval = 1, loop = TRUE))
           
           
    )
  ),
  
  fluidRow(
    DT::dataTableOutput("table")
  )
)
  

  
server<-
  function(input, output) {
    
    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
      data <- data
      if (input$model != "All") {
        data <- data[data$name == input$model,]
      }
      if (input$cyl != "All") {
        data <- data[data$cyl == input$cyl,]
      }
      if (input$year != "All") {
        data <- data[data$year == input$year,]
      }
      data
    }))
    
  }


shinyApp(ui = ui, server = server)

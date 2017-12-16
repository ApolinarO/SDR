#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
install.packages("datasets")
library("datasets")

data <- NHANES_2007_2014[,-1]

vchoices <- 1:ncol(data)
names(vchoices) <- names(data)

runApp(
    list(
      ui = basicPage(
      
      # Sidebar panel for inputs ----
         # sidebarPanel(
        # Input: Choose dataset ----
        selectInput("dataset", "Choose a dataset:",
                   choices = c("NHANES")),
        # Button
           downloadButton("downloadData", "Download"),
          
       
    vchoices <- 1:ncol(data),
    names(vchoices) <- names(data),
    checkboxGroupInput("columns","Select Columns",choices=vchoices,inline = T),
    dataTableOutput('mytable')
    
  )
  
  ,
  server = function(input, output) {
    
    observeEvent(input$columns,{
      cols <- as.numeric(input$columns)
      if(length(input$columns) == 1){
        df <- data.frame(data[,cols])
        names(df) <- names(data)[cols]
        output$mytable = renderDataTable(df)
        
      }else{
        output$mytable = renderDataTable(data[,cols])
        
      }
    })
    #Reactive values for selected dataset
    datasetInput <- renderDataTable(df)
    # Table of selected dataset ----
    output$table <- renderTable({
      datasetInput()
    })
    #Downloadable csv of selected dataset
    output$downloadData <- downloadHandler(
      filename = function() {
        paste(input$dataset, ".csv", sep = "")
      },
      content = function(file) {
        write.csv(datasetInput(), file, row.names = FALSE)
      }
    )
  }
))


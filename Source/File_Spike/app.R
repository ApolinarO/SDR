library(shiny)
library(DT)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File"),
      #selectInput("col", "Select a column", character(0))
      checkboxGroupInput("columns","Select Columns",character(0)),
      actionButton("updateButton","Update View"),
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput("table"),
      textOutput("selected")
    )
  )
)

server <- function(input, output, session) {
  
  ###get and load data
  data <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })
  
  #display output
  output$table <- renderTable({
    req(data())
    head(data())
  })
  
  #display and update column selection
  observeEvent(data(), {
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
  })
  
  
      
  
  #update the table 
  observeEvent(input$updateButton, {
    df <- data.frame(data())
    df <- subset(df, select = input$columns) #subsetting takes place here
   # browser()
    output$table <- renderTable({
      req(df)
      head(df)
    })
  })
 # 
# observeEvent(input$downloadButton, {
#  #df <- subset.data.frame(data(),input$columns) #subsetting takes place here
#    output$downloadData <- downloadHandler(
#      
#      filename = function() {
#        paste(data.frame(data()), ".csv", sep = "")
#      },
#      content = function(file) {
#        write.csv(data.frame(data()), file, row.names = FALSE)
#      }
#    )
#  })
  
#change_df <- function(){
#  df <- subset(data.frame(data()), input$columns)
#  return (df)
#}
  
datasetInput <- reactive({
  
  df <- subset(data.frame(data()), select = input$columns)
  
})
output$downloadData <- downloadHandler(

    filename = function() {
      paste(data.frame(data()), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
}

shinyApp(ui, server)
library(shiny)
library(DT)
library(dplyr)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File"),
      #selectInput("col", "Select a column", character(0))
      checkboxGroupInput("columns","Select Columns",character(0)),
      actionButton("updateButton","Update View"),
      actionButton("subset", "Subset Rows"),
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
  
  #use server to get information from the table
  observeEvent(input$subset,{
    df <- data.frame(data()) 
    str(df)
    print("subsetting removes NAS")
    df <- na.omit(df)
    output$selected <- renderText(
      #cols <- input$columns,
      for (x in input$columns){
        print(paste("this is ", x))
        print(typeof(x)) #views ints as char??
        col <- select(df,contains(x))
        if(!is.na(is.numeric(x))){
          
          values <- select(df, contains(x))
         # print(values)
          print('got here')
          #print(min(values))
          #print(max(values))
          output$UI_button <- insertUI(
            selector = "#subset",
            where = "afterEnd",
            ui = actionButton("updateSub", "Apply Subsetting")

          )
          
          output$UI_button <- insertUI(
            selector = "#subset",
            where = "afterEnd",
               ui = sliderInput("int", x,
                            min = min(values), max = max(values),
                             value = c(min(values),max(values)))
          )
        }
      }
      
    )
    
    
  })
  
  ##apply changes based on subset button
  observeEvent(input$updateSub, {
    ##change the data frame
  
    df <- data.frame(data())
    df <- filter(df, input$int) #subsetting takes place here
    # browser()
    output$table <- renderTable({
      req(df)
      head(df)
    })
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
library(shiny)
library(DT)
library(dplyr)


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File"), #choose a file
      
      #check box for columns
      #will only show up when user has selected a csv
      checkboxGroupInput("columns","Select Columns",character(0)), #filter columns
      
      actionButton("updateCol","Update Columns"), #update view for columns-----why cant it work for rows?
      actionButton("subset", "Subset Rows"), #subset is defined by its ability to filter observations (rows)
   #   actionButton("updateRow", "Update Rows"),
       downloadButton('downloadData', 'Download') #download 
    
      
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
  
  #display the possible columns you can pick from
  observeEvent(data(), {
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
  })
  
  
  #update the table based on column selection
  observeEvent(input$updateCol, {
    df <- data.frame(data())
    df <- subset(df, select = input$columns) #column selection takes place here
    #df <- subset(df, input$col >= min(input$int) & input$col <= max(input$int))
    # browser()
    output$table <- renderTable({
      req(df)
      head(df)
    })
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
        col <- select(df,contains(x))
        ##if the column has no NAS
        ##and if it is numeric
        ##apply subsetting by slider
        if(!is.na(is.numeric(x))){
          
            values <- select(df, contains(x))
            print('got here')
#            output a button to update the subset range for the slider
           
            
            output$UI_slide <- insertUI(
                selector = "#subset",
                where = "afterEnd",
                ui = sliderInput("int",label = x,
                            min = min(values), max = max(values),
                             value = c(min(values),max(values)))
                
                
              ) #end UI_Button
              print("this should not happen twice")
             call_function(x)
            # datasetInput <- reactive({
            #  df <- filter(df, x >= min(input$int) & x <= max(input$int))
              
            #})
            
           
          } #end if for numeric input
      }#end for
      
    )#end output$selected 

  })
  
  #output$table <- renderTable({
   ## x <- reactive(
  #    df <- data.frame(data()),
  ##    subset(df, input$col >= min(input$int) & input$col <= max(input$int))
   #3    )# end reactive
  ##  req(x)
    #head(df)
 # })
  call_function <- function(x){
    print("in function")
    print(x)
    rows <- select(df, contains(x))
    output$UI_button <- insertUI(
      selector = "#subset",
      where = "afterEnd",
      ui = actionButton("updateRow", "Update Row")
      
    ) #end UI_button
    
    observeEvent(input$updateRow, {
      df <- data.frame(data())
      print(str(df))
      print(x)
      print(rows)
      rows <- select(df, contains(x))
      print(rows)
     #df <- filter(df, between(rows, min(input$int), max(input$int))) #row selection takes place here
      df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
      output$table <- renderTable({
        req(df)
        head(df)
      })
    })
  }
  ##apply changes based on subset functions
  observeEvent(input$updateSub, {
    ##change the data frame
    print("---got here")
    df <- data.frame(data())
    print(min(input$int))
    print(max(input$int))
    print(input$col)
    df <- filter(df, input$int) #subsetting takes place here
    print("got here---------")
    # browser()
    output$table <- renderTable({
      req(df)
      head(df)
    }) #end the rendering of new table
  })# end observeEvent
      
  
 
##REACTIVELEY for download
datasetInput <- reactive({
  
  df <- subset(data.frame(data()), select = input$columns)
  
})


##download the dataframe
output$downloadData <- downloadHandler(

    filename = function() {
      paste(data.frame(data()), ".csv", sep = "") ##will add functionality for different data types later
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
}

shinyApp(ui, server)
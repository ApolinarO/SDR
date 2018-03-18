
print("hello")
#runApp('C:/HOME/SDR/Source/wranglR_v.0.2')
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
      actionButton("deleteSliders", "Delete Sliders"),
      textInput("dataName", "Name your file", width = "50%"),
      downloadButton('downloadData', 'Download') #download 
      
      
    ),
    mainPanel(
      tableOutput("table"),
      textOutput("selected")
    )
  )
 
)
server <- function(input, output, session) {
  data <- reactive({
    inFile <- input$file1
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })
  
  output$table <- renderTable({
    req(data())
    head(data())
  })
  
  #display the possible columns you can pick from
  observeEvent(data(), {
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
  })
  
  
  observeEvent(input$deleteSliders, {
    print("delete something")
    delete_sliders()
    delete_updateButton()
  })
  
  #update the table based on column selection
  observeEvent(input$updateCol, {
    df <- data.frame(data())
    df <- subset(df, select = input$columns) #column selection takes place here
    for (x in input$columns){
      delete_sliders()
      #delete_updateButton()
    }
    #delete_sliders()
    slides <- Subset_Columns(input$columns)
    print(slides)
    
    output$table <- renderTable({
      req(df)
      head(df)
    })
    
  })
  
  Subset_Columns <- function(columns){
    slideVector <- c()
    df <- data.frame(data())
   # print("IN THIS BITCH")
    for (x in columns){
      print(x)
      
      #col <- select(df,contains(x))
      ##if the column has no NAS
      ##and if it is numeric
      ##apply subsetting by slider
      if(!is.na(is.numeric(x))){
      
        
        values <- select(df, contains(x))
        print('got here')
        #            output a button to update the subset range for the slider
        slide_id <- paste("slide_",x,sep = "")
        slideVector <-c(slideVector,slide_id)
        
       
        output$UI_slide <- insertUI(
          print("inside the slide"),
          selector = "#updateCol",
          where = "afterEnd",
          ui = sliderInput(inputId = "int" , label = x,
                           min = min(values), max = max(values),
                           value = c(min(values),max(values)))
          #multiple = TRUE
          # print("leaving slide")
          #multiple = TRUE
        ) #end UI_Button
        
        
         
        #?sliderInput
        #?insertUI
        #luke(x)
        #call_function2(x)
      }
    }
    return (slideVector)
    
  }
  
  
  
  
  
  dataTable <- reactive({
   df <- data.frame(data())
   df <- subset(df, rows >= min(input$X.1) & rows <= max(input$X.1))
    
  })
  
  output$dTable <- renderDataTable({
    dataTable()
  } #, options = list(bFilter = FALSE, iDisplayLength = 50)
  )
  
  
  luke <- function(x){ #You are my only hope
   # print(x)
    observeEvent(input$int, {
    #  df <- data.frame(data())
     # rows <- select(df, contains(x))
      print(min(input$int))
      print(max(input$int))
     # print(str(df))
    #  print("-----")
      #df <- data.frame(data())
      #df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
      #df <- subset(df, select = input$columns)
    })
    
    #output$table <- renderTable({
    #  req(df)
    #  head(df)
    #} #, options = list(bFilter = FALSE, iDisplayLength = 50)
    #)
    

  }
  
  
  observeEvent(input$int, {
   # rows <- select(df, contains(x))
    print(min(input$int))
    print(max(input$int))
   
    
  })
  
  
  
  call_function <- function(x){
    #print("in function")
   # print(x)
    rows <- select(df, contains(x))
   # df <- data.frame(data())
   # df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
    #df <- subset(df, select = input$columns)
    #print(str(df))
    
    
    
     output$UI_button <- insertUI(
      selector = "div:has(> #int)",
      where = "afterEnd",
      ui = actionButton("updateRow", "Update Row")
      
    ) #end UI_button
    
    observeEvent(input$updateRow, {
      print("updating---")
      print(x)
      df <- data.frame(data())
      print(str(df))
      print(x)
      #print(rows)
      rows <- select(df, contains(x))
      #print(rows)
      #df <- filter(df, between(rows, min(input$int), max(input$int))) #row selection takes place here
      print(input$int)
      df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
      df <- subset(df, select = input$columns)
      
      
     
      output$table <- renderTable({
        req(df)
        head(df)
      })
    })
  }#end call_function
  
  
  call_function2 <- function(x){
    #print("in function")
    # print(x)
    rows <- select(df, contains(x))
    # df <- data.frame(data())
    # df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
    #df <- subset(df, select = input$columns)
    #print(str(df))
    selecte <- paste("div:has(>#",x,")", sep = "")
    button <- paste("updateRow",x,sep ="")
    print(selecte)
    print("creating a button ")
    
    
    output$UI_button <- insertUI(
     
      selector = selecte,
      where = "afterEnd",
      ui = actionButton(button, button)
      
    ) #end UI_button
    
    observeEvent(input$button, {
      print("updating---")
      print(x)
      df <- data.frame(data())
      print(str(df))
      print(x)
      #print(rows)
      rows <- select(df, contains(x))
      #print(rows)
      #df <- filter(df, between(rows, min(input$int), max(input$int))) #row selection takes place here
      print(input$int)
      df <- subset(df, rows >= min(input$int) & rows <= max(input$int))
      df <- subset(df, select = input$columns)
      
      
      
      output$table <- renderTable({
        req(df)
        head(df)
      })
    })
  }#end call_function
  
  
  delete_sliders<- function(){
    print("delete a slider")
    removeUI(
      selector = "div:has(> #int)"
    )
  }
  #delete_updateButton <- function(){
  #  print("deleting a button")
  #  removeUI(
  #    selector = "div:has(> #updateRow)"
  #  )
    
#  }
  
  
  
  
  
  
  
  ##REACTIVELEY for download
  datasetInput <- reactive({
    if(!is.null(input$columns)){
      df <- subset(data.frame(data()), select = input$columns)
      
      
    }
    else{
      df <- data.frame(data())
    }
  })
  
  ##download the dataframe
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataName, ".csv", sep = "") ##will add functionality for different data types later
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
#print(output$UI_slide)
 
}
shinyApp(ui, server)


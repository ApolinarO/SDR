#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



library(shiny)
library(DT)
library("purrr")
ui <- 
  
  navbarPage("wranglR",
             
             tabPanel("README",
                      h2("WELCOME TO wranglR release 1", align="center"),
                      p("Objective: To create an web application that will expedite the Data Wrangling Process"),
                      p("Data Selection section will allow you to upload a csv file and select columns"),
                      strong("NOTE: ROW SELECTION WILL BE IMPLEMENTED IN RELEASE 2"),
                    
                     p("Data Merging section will allow you to merge multiple tables based on a common index"),
                     strong("NOTE: INDEX MUST BE FOUND THROUGHOUT ALL TABLES"),
                     
                     p("Yet to come"),
                     HTML(" <ul>
                       <li>Row selection using slider input objects</li>
                       <li>Data stacking using rbind()</li>
                          </ul>"),
                     
                     p("Download the data Here"),
                     downloadButton('downloadNHANES', 'Download NHANES')
                    
             )
             ,
             tabPanel("Data Selection",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("file", "Choose CSV File"),
                            #selectInput("col", "Select a column", character(0))
                            checkboxGroupInput("columns","Select Columns",character(0)),
                            actionButton("updateButton","Update View"),
                            textInput("dataName", "Name your file", width = "50%"),
                            downloadButton('downloadData', 'Download')
                          ),
                          mainPanel(
                            tableOutput("table1"),
                            textOutput("selected")
                          )
                        )
                      )
             )
             ,
             
             tabPanel("Data merging",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("csvs", "Choose CSV File",multiple=TRUE),
                            textInput("dataName", "Name your file", width = "50%"),
                            downloadButton('downloadData2', 'Download')
                          ),
                          mainPanel(
                            tableOutput("table2")
                          )
                        )
                      )
                      
                      
             ) 			
          
  )



server <- function(input, output, session) {
  ####	Sube Setting Data	####
  ###get and load data
  data <- reactive({
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })
  
  #display output
  output$table1 <- renderTable({
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
    output$selected <- renderText(
      #cols <- input$columns,
      for (x in input$columns){
        print(paste("this is ", x))
        print(typeof(x)) #views ints as char??
      }
      
    )
    
    
  })
  
  
  #update the table 
  observeEvent(input$updateButton, {
    df <- data.frame(data())
    df <- subset(df, select = input$columns) #subsetting takes place here
    # browser()
    output$table1 <- renderTable({
      req(df)
      head(df)
    })
  })
  
  datasetInput <- reactive({
    
    df <- subset(data.frame(data()), select = input$columns)
    
  })
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataName, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
  #Merging

  mycsvs<-reactive({
    Reduce(function(x,y) merge(x, y, by = "seqn", all.x = TRUE, all.y = TRUE),lapply(input$csvs$datapath, read.csv))
  })
  
  output$table2 <- renderTable({
    req(mycsvs())
    head(mycsvs())
  })  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste(input$dataName, ".rda", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  ) 
  
  #Stacking
  
#  rbind_sort_func <- function(...){
 #   new_df1 <- (...)
#    new_df <- rbind(new_df1[1:length(...)])
#    print("New DF CReated")
 #   str(new_df)
    #sorted_data <- new_df[order(new_df$Order1),]
    #return(sorted_data)
#    return(new_df[1])
 # }
  
  observeEvent(input$stack,{
    print("test")
    mycsvs1<-reactive({
      A <- lapply(input$csvs1$datapath, read.csv)
      print(str(A))
      print("test1")
      rbind_sort_func(lapply(input$csvs1$datapath, read.csv))
      #print("test2")
    })
    
    output$table3 <- renderTable({
      req(mycsvs1())
      head(mycsvs1())
    })
  })
  
  output$downloadNHANES <- downloadHandler(
    filename = function() {
      "files.zip"
    },
    content = function(file) {
      zip(zipfile=file, files="./NHANES_CLEAN")
    }
  )
      
}

shinyApp(ui, server)


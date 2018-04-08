#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

<<<<<<< HEAD
library(Hmisc)
library(SASxport)

library(shiny)
library(DT)
#library("purrr")

=======


library(shiny)
library(DT)
library("purrr")
library(ISLR)
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
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
                      downloadButton('downloadNHANES', 'Download NHANES'),
                      p("Dataset documentation"),
                      strong("DISCLAIMER: For this small, sanitized dataset, dataframe columns are consistent across all years"),
                      HTML("<ul>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/DEMO_H.htm'>Demographics</a></li>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HEPC_H.htm'>Hepatitis C: RNA (HCV-RNA) and Hepatitis C Genotype </a></li>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/TRIGLY_H.htm'>Cholesterol - LDL & Triglycerides </a></li>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HDL_H.htm'>Cholesterol - HDL</a></li>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/HIV_H.htm'>HIV Antibody Test</a></li>
                           <li><a href='https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/BMX_H.htm'>Body Measures</a></li>
                           </ul>")
                      
                      )
             ,
<<<<<<< HEAD
    
             
             tabPanel("SAS XPT to CSV Converter",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("xptfile", "Choose XPT File"),
                            #selectInput("col", "Select a column", character(0))
                            textInput("directoryName", "Please Specify output directory"),
                            textInput("new_dataName", "Name your file", width = "50%"),
                            actionButton('convert','Convert XPT to CSV'),
                            downloadButton('newCSV_downloadData', 'Download')
                          ),
                          mainPanel(
                            DT::dataTableOutput("mytable32")
                           # textOutput("selected")
                          )
                        )
                      )
             ) #end tab panel
             ,
             
             
=======
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
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
                            DT::dataTableOutput("mytable1"),
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
                            textInput("dataName2", "Name your file", width = "50%"),
                            downloadButton('downloadData2', 'Download')
                          ),
                          mainPanel(
                            DT::dataTableOutput("table2")
                          )
                        )
                      )
                      
                      
<<<<<<< HEAD
             ),
             
             
             tabPanel("Data Stacking",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("csvs2", "Choose CSV File",multiple=FALSE),
                            fileInput("csvs3", "Choose CSV File",multiple=FALSE),
                            textInput("dataName_stack", "Name your file", width = "50%"),
                            downloadButton('downloadData3', 'Download')
                          ),
                          mainPanel(
                            DT::dataTableOutput("table3")
                          )
                        )
                      )
             )		
             
  )
=======
             ) 			
             
                      )
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65



server <- function(input, output, session) {
  ####	Sub Setting Data	####
  ###get and load data
  data <- reactive({
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })
<<<<<<< HEAD

=======
  
  
  
  
  
  #output$mytable1 <- DT::renderDataTable({
  # DT::datatable(mtcars, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  #})
  
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
  #display output
  output$mytable1 <- DT::renderDataTable({
    df <- as.data.frame(data())
    DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
    
  })
  
<<<<<<< HEAD
  ### DATA SELECTION
  
  #display and update column selection
  observeEvent(data(), {
    
    removeUI( selector = "div:has(> #rows)") ## clear up any previous slides
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
    df <- data.frame(data())
=======
  #display and update column selection
  observeEvent(data(), {
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
    df <- data.frame(data())
    print("inside this thing right here")
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
      insertUI(
      print("inside the slide"),
      #print(nrow(df)),
      #print(max(nrow(df))),
      selector = "#updateButton",
      where = "beforeBegin",
      ui = sliderInput(inputId = "rows" , label = "Observations",
                       min = 1, max = nrow(df),
                       value = c(1,nrow(df)), width = "200%")
    ) #end UI_Button
    
  })
  
  
  
<<<<<<< HEAD
=======
  
  
  
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
  
  
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
  #update the table 
  observeEvent(input$updateButton, {
    df <- data.frame(data())
    df <- df[min(input$rows):max(input$rows),]
    print(max(input$rows))
    print(min(input$rows))
<<<<<<< HEAD
    df <- subset(df,select = input$columns) # column subsetting takes place here
    
    output$mytable1 <- DT::renderDataTable({
      DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  
    })
  })
  
  
  ###DATA SELECTION INPUT FOR Downloaded Data
  datasetInput <- reactive({
    df <- subset(data.frame(data()), select = input$columns) ##column selection
    df <- df[min(input$rows):max(input$rows),] #row selection
  })
  
  ##DATA SELECTION DOWNLOAD
=======
    df <- subset(df,select = input$columns) #subsetting takes place here
    
    # browser()
    output$mytable1 <- DT::renderDataTable({
      #req(df)
      #head(df)
      DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
      
    })
  })
  
  datasetInput <- reactive({
    
    df <- subset(data.frame(data()), select = input$columns)
    df <- df[min(input$rows):max(input$rows),]
  })
  
  
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataName, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
<<<<<<< HEAD
  
  
  
  #Merging
=======
  #Merging
  
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
  mycsvs<-reactive({
    Reduce(function(x,y) merge(x, y, by = "seqn", all.x = TRUE, all.y = TRUE),lapply(input$csvs$datapath, read.csv))
  })
  
  output$table2 <- renderDataTable({
    #req(mycsvs())
    #head(mycsvs())
    df <- as.data.frame(mycsvs())
    DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
    
  })  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste(input$dataName2, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(as.data.frame(mycsvs()), file, row.names = FALSE)
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
      #req(mycsvs1())
      #head(mycsvs1())
      df <- as.data.frame(mycsvs1())
      DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))      
    })
  })
  
  output$downloadNHANES <- downloadHandler(
    filename = function() {
      "files.zip"
    },
    content = function(file) {
<<<<<<< HEAD
      zip(zipfile=file, files="./NHANES_CLEAN")
    }
  )
  
  
  
  ###XPT To CSV Converter
  
  check_dir <-function(directory){
    
    flag <-0
    result <- tryCatch({
      setwd(directory)
      print('about to process my data')
      return(flag)
      
    }, warning = function(war) {
      
      # warning handler picks up where error was generated
      print('warning')
      flag <- -1
      return(flag)
    }, error = function(err) {
      
      showNotification(paste("ERROR, DID NOT SELECT PROPER DIRECTORY "), duration = 5,type = 'error')
      Sys.sleep(5)
      flag <- -1
      return(flag)
      
    }, finally = {
      print('Exiting Try Catch')
    }) # END tryCatch
    
  }
  XpttoCsv.func <- function(a,b,c=NULL){
      xpt.name <- paste(a) #get the name of the xpt file
      csv.name <- paste(c,b,".csv",sep="") #create path and file name of new csv
      dat <- sasxport.get(xpt.name) # conversion
      write.csv(dat[,-1],file=csv.name,row.names = FALSE)
  }
  
  
  observeEvent(input$convert, {
    if (is.null(input$xptfile)) print('select a damn file')
    
    xpt <-input$xptfile
    print('data is loaded')
    xpt.name <- xpt$name
    dir.output <- input$directoryName
    new_csv_name <- input$new_dataName
    val <- check_dir(dir.output) #function to check directory
    if(val == 0){  #convert only if we have a valid directory
      XpttoCsv.func(xpt.name,new_csv_name,dir.output)
      
    }


  })
  
  
  ###data stacking stufff
  
  
  # Row Merging
  
  row.merge.csvs <- reactive({
    row1 <- lapply(input$csvs2$datapath, read.csv)
    row1 <- as.data.frame(row1)[,-1]   # Removing Index created by CSV Read in
    row2 <- lapply(input$csvs3$datapath, read.csv)
    row2 <- as.data.frame(row2)[,-1]  # Removing Index created by CSV Read in
    merge(row1, row2, by =intersect(names(row1),names(row2)) ,all=TRUE)
  })
  
  output$table3 <- renderDataTable({
    clean.csvs3 <- as.data.frame(row.merge.csvs())
   # clean.csvs3 <- clean.csvs3[, -grep(".x", colnames(clean.csvs3))] # Dropping any duplicated values from first CSV
    #clean.csvs3 <- clean.csvs3[, -grep(".y", colnames(clean.csvs3))] # Dropping any duplicated values from second CSV
    print(nrow(clean.csvs3))
    View(clean.csvs3)
    DT::datatable(clean.csvs3, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })  
  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste(input$dataName_stack, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(clean.csvs3, file, row.names = FALSE)
    }
  ) 


  
  
  
=======
      zip(zipfile=file, files=file.path(".", "NHANES_CLEAN"))
    }
  )
  
>>>>>>> 946003017209cfc129bb86fab4f3a56546260e65
}

shinyApp(ui, server)


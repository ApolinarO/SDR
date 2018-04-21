#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com
# Authors: Antonio Ruiz, Apolinar Ortega, Jacob Darling
#
#

library(Hmisc)
library(SASxport)
library(shiny)
library(DT)
library(rio)
library(tools)
#library("purrr")
ui <- 
  
  navbarPage("wranglR",
             
             tabPanel("README",
                      h2("WELCOME TO wranglR release 1", align="center"),
                      p("Objective: To create an web application that will expedite the Data Wrangling Process"),
          
                      strong("XPT to CSV CONVERTER"),
                      p("If you have XPT files on your local machine that you would like to convert use this tool"),
                      p("NOTE: When specifying output directory, enter full file path for the converted csv (ex. /home/dir1/dir2/....)"),
                      strong("DATA SELECTION"),
                      p("Choose a csv file that you have on your local machine and select the columns that you want subset the observations that you want."),
                      strong("DATA MERGING"),
                      p("DATA MERGING"),
                      p("Choose multiple csv files and merge them together by SEQN variable"),
                      p("NOTE: STRONGLY RECOMMENDED THAT YOU MERGE DATA FILES BY YEAR"),
                      p("DATA STACKING"),
                      p("Choose a table type that has been found across mulitple years (ex. Demo_H,Demo_G,..etc"),
                      
                      p("Data Merging section will allow you to merge multiple tables based on a common index"),
                      strong("NOTE: INDEX MUST BE FOUND THROUGHOUT ALL TABLES"),
                      
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
    
             
             tabPanel("SAS XPT to CSV Converter",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("xptfile", "Choose XPT File"),
                            downloadButton('downloadData_xpt', 'Download')
                          ),
                          mainPanel(
                            DT::dataTableOutput("mytableXPT")
                          )
                        )
                      )
             ) #end tab panel
             ,
             
             
             tabPanel("Data Selection",
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            fileInput("file", "Choose CSV File"),
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



server <- function(input, output, session) {
  # Allows for more upload size
  options(shiny.maxRequestSize=100*1024^2)
          

  ####	Sub Setting Data	####
  ###get and load data
  data <- reactive({
    inFile <- input$file
    if (is.null(inFile)) return(NULL)
    read.csv(inFile$datapath)
  })

  #display output
  output$mytable1 <- DT::renderDataTable({
    df <- as.data.frame(data())
    DT::datatable(df, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
    
  })
  
  ### DATA SELECTION
  
  #display and update column selection
  observeEvent(data(), {
    
    removeUI( selector = "div:has(> #rows)") ## clear up any previous slides
    updateCheckboxGroupInput(session, "columns", choices = names(data()))
    df <- data.frame(data())
      insertUI(
      print("inside the slide"),
      selector = "#updateButton",
      where = "beforeBegin",
      ui = sliderInput(inputId = "rows" , label = "Observations",
                       min = 1, max = nrow(df),
                       value = c(1,nrow(df)), width = "200%")
    ) #end UI_Button
    
  })
  
  
  
  #update the table 
  observeEvent(input$updateButton, {
    df <- data.frame(data())
    df <- df[min(input$rows):max(input$rows),]
    print(max(input$rows))
    print(min(input$rows))
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
  
  
   merge_data <- reactive({
    df <- mycsvs()
  })
  output$table2 <- renderDataTable({
    DT::datatable(merge_data(), options = list(lengthMenu = c(5, 30, 50), pageLength = 5))

  })
  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      paste(input$dataName2, ".csv", sep = "")
    },

    content = function(file) {
      write.csv(merge_data(), file, row.names = FALSE)
    }
  ) 
  
  
  
  output$downloadNHANES <- downloadHandler(
    filename = function() {
      "files.zip"
    },
    content = function(file) {
      zip(zipfile=file, files="./NHANES_CLEAN")
    }
  )
  
  
  
  #NOTE DEPENDENCIES FOR XPT Conversion
  #----sudo apt-get install libxml2-dev------
  #----sudo apt-get install libudunits2-dev-----
  #----install.packages('rio')--------
  #----install.package('tools')-------
 ##xpt converter
  
  #BY Default will take an XPT File and Convert to XPT
  output$downloadData_xpt <- downloadHandler(
    filename = function() {
      name <- basename(file_path_sans_ext(input$xptfile$name))
      print(name)
      paste0(name, '.csv')
    },
    content = function(file) {
      input_file <- input$xptfile
      input_file_format <- tools::file_ext(input_file$name)
  
      if (is.null(input_file))
        return(NULL)
      else {
        db <- rio::import(file = input_file$datapath,
                          format = input_file_format)
        
          df <- rio::export(x = db,
                      file = file, 
                      format = 'csv')
        
      }
    }
  )
 
  ###data stacking stufff
  
  
  # Row Merging
  
  row.merge.csvs <- reactive({
    row1 <- lapply(input$csvs2$datapath, read.csv)
    row1 <- as.data.frame(row1)[,-1]   # Removing Index created by CSV Read in
    row2 <- lapply(input$csvs3$datapath, read.csv)
    row2 <- as.data.frame(row2)[,-1]  # Removing Index created by CSV Read in
    merge(row1, row2, by =intersect(names(row1),names(row2)) ,all=TRUE)
  })
  
  stack_rows <- reactive({
     df <- row.merge.csvs()
      
    })
  
  output$table3 <- renderDataTable({
    DT::datatable(stack_rows(), options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })  
  
  output$downloadData3 <- downloadHandler(
    filename = function() {
      paste(input$dataName_stack, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(stack_rows(), file, row.names = FALSE)
    }
  ) 
}

shinyApp(ui, server)


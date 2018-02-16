library(DBI)
library(pool)


pool <- dbPool(
  drv = RMySQL::MySQL(),
  dbname = "university",
  host = "127.0.0.1",
  username = "root",
  password = "tony"
)

table1<- dbReadTable(conn = pool,  name = 'class', value = as.data.frame(table1))
table2<- dbReadTable(conn = pool,  name = 'enrolled', value = as.data.frame(table2))
table3<- dbReadTable(conn = pool,  name = 'faculty', value = as.data.frame(table3))
table4<- dbReadTable(conn = pool,  name = 'student', value = as.data.frame(table4))



ui <- fluidPage(
  
  titlePanel("R SHINY CORE DEMO"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("class", "enrolled","faculty","student")),
      
      numericInput("obs", "Number of observations to view:", 10),
                  conditionalPanel(
                   'input.dataset === "class"',
                   checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                                      names(table1), selected = names(table1))
                 ),
                conditionalPanel(
                  'input.dataset === "enrolled"',
                  checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                                     names(table2), selected = names(table2))
                ),            
                conditionalPanel(
                    'input.dataset === "faculty"',
                    checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                                       names(table3), selected = names(table3))
                  ),
                 
                conditionalPanel(
                  'input.dataset === "student"',
                  checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                                     names(table4), selected = names(table4))
                ),
      submitButton("Update View")
          ),
  
  mainPanel(
    
    h4("Observations"),
    tableOutput("view")
  )
  )
)

server <- function(input, output, session) {
  
  #data <- c('class', 'enrolled', 'faculty','student')
  
 #list_data <- list()
  
  #for(i in 1:length(data)) {
  #      list_data[i] <- dbReadTable(conn = pool,  
  #                                         name = data[i], 
   #                                        value = as.data.frame(list_data[i]))
   #                                 }
  
  
  
  # Return the requested dataset
  datasetInput <- reactive({
    
    switch(input$dataset,
           "class" = table1,
           "enrolled" = table2,
           "faculty" = table3,
           "student" = table4
    )
    
  })
  

  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
    
    })
  
  
}

shinyApp(ui, server)
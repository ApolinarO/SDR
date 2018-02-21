library(shiny)

# Spike that populates a select list input from local files
  # Uses data from /NHANES_CSV/2007_2008
test.files.in.select.list <- function(){
  files = list.files("./NHANES_CSV/2007_2008", all.files=F, full.names=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set", h3("Select Data Set"), choices=files, selected=1)
  )
  
  server = function(input, output, session){
    output$data.set = renderText({
      outpout$data.set
      })
  }
  shinyApp(ui=ui, server=server)
}

# Same as the spike above, but it includes all files in /NHANES_CSV
test.files.in.select.list.all <- function(){
  files = list.files("./NHANES_CSV/", all.files=F, full.names=F, recursive=T, include.dirs=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set", h3("Select Data Set"), choices=files, selected=1)
  )
  
  server = function(input, output, session){
    output$data.set = renderText({
      outpout$data.set
    })
  }
  shinyApp(ui=ui, server=server)
}

# Spike to download file from select list item
  # Uses data from /NHANES_CSV/2007_2008
test.download.and.select.lists <- function(){
  files = list.files("./NHANES_CSV/2007_2008", all.files=F, full.names=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set", h3("Select Data Set"), choices=files, selected=1),
    downloadButton('downloadData', 'Download')
  )
  
  server = function(input, output){
    file.to.download <- eventReactive(input$data.set, {
      paste0("./NHANES_CSV/2007_2008/", input$data.set, ".csv")
    })
    
    output$downloadData <- downloadHandler(
      filename = function() {
        file.to.download()
      },
      content = function(file) {
        file.copy(from=file.to.download(), to=file)
      }
    )
  }
  shinyApp(ui=ui, server=server)
}

# Spike to download the entire data set
  # Note that it takes some time tp process
test.download.all.zipped <- function(){
  files.to.zip = "./NHANES_CSV"
  
  ui <- fluidPage(
    downloadButton('downloadData', 'Download All')
  )
  
  server = function(input, output){
    output$downloadData <- downloadHandler(
      filename = function() {
        "files.zip"
      },
      content = function(file) {
        zip(zipfile=file, files=files.to.zip)
      }
    )
  }
  shinyApp(ui=ui, server=server)
}

# Spike to select multiple file to download together in a zip format
  # Uses data from /NHANES_CSV/2007_2008
test.download.multiple.in.zipepd <- function(){
  files = list.files("./NHANES_CSV/2007_2008", all.files=F, full.names=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set1", h3("Select Data Set 1"), choices=files, selected=1),
    selectInput("data.set2", h3("Select Data Set 2"), choices=files, selected=1),
    downloadButton('downloadData', 'Download')
  )
  
  server = function(input, output){
    file.to.download1 <- eventReactive(input$data.set1, {
      paste0("./NHANES_CSV/2007_2008/", input$data.set1, ".csv")
    })
    file.to.download2 <- eventReactive(input$data.set2, {
      paste0("./NHANES_CSV/2007_2008/", input$data.set2, ".csv")
    })
    
    output$downloadData <- downloadHandler(
      filename = function() {
        "data.zip"
      },
      content = function(file) {
        print(c(file.to.download1(), file.to.download2()))
        zip(zipfile=file, files=c(file.to.download1(), file.to.download2()))
      }
    )
  }
  shinyApp(ui=ui, server=server)
}

# Does the same as the spike above, but with a single selectInput item
test.download.multiple.in.zipepd2 <- function(){
  files = list.files("./NHANES_CSV/2007_2008", all.files=F, full.names=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set", h3("Select Data Set"), choices=files, selected=1, multiple=T),
    downloadButton('downloadData', 'Download')
  )
  
  server = function(input, output){
    files.to.download <- eventReactive(input$data.set, {
      paste0("./NHANES_CSV/2007_2008/", input$data.set, ".csv")
    })
    
    output$downloadData <- downloadHandler(
      filename = function() {
        "data.zip"
      },
      content = function(file) {
        zip(zipfile=file, files=files.to.download())
      }
    )
  }
  shinyApp(ui=ui, server=server)
}

# Spike that disallows two select list items to select the same items
test.two.select.list.items <- function(){
  files = list.files("./NHANES_CSV/2007_2008", all.files=F, full.names=F)
  files = gsub("\\.\\w+", "", files)
  names(files) = files
  
  ui <- fluidPage(
    selectInput("data.set1", h3("Select Data Set 1"), choices=files[-1], selected=1),
    selectInput("data.set2", h3("Select Data Set 2"), choices=files[-2], selected=2)
  )
  
  server = function(input, output, session){
    observeEvent(input$data.set1,{
      updateSelectInput(session = session,
                        inputId = "data.set2",
                        choices = files[files != input$data.set1],
                        selected = input$data.set2)
    })
    
    observeEvent(input$data.set2,{
      updateSelectInput(session = session,
                        inputId = "data.set1",
                        choices = files[files != input$data.set2],
                        selected = input$data.set1)
    })
  }
  shinyApp(ui=ui, server=server)
}

# Allows user to select by year and then by data set available
test.select.by.year.then.file <- function(){
  # Gets folders in /NHANES_CSV
  folders = list.dirs("./NHANES_CSV")[-1]
  folders = gsub("./NHANES_CSV/", "", folders)
  
  # For each sub-folder, adds in a list of thier local files
  folders.list = list()
  for(folder in folders){
    files = list.files(paste0("./NHANES_CSV/", folder))
    names(files) = gsub("\\.\\w+", "", files)
    
    folders.list[[folder]] = files
  }
  
  ui <- fluidPage(
    selectInput("year.folder", h3("Year"), choices=folders, selected=1),
    selectInput("data.set", h3("Data Set"), choices=folders.list[[1]], selected=2),
    downloadButton("download.data", "Download")
  )
  
  server = function(input, output, session){
    
    # Updates 'Data Set' select list
    observeEvent(input$year.folder,{
      updateSelectInput(session = session,
                        inputId = "data.set",
                        choices = folders.list[[input$year.folder]]
                        )
    })
    
    output$download.data <- downloadHandler(
      filename = function() {
        input$data.set
      },
      content = function(file) {
        file.copy(from=paste0("./NHANES_CSV/", input$year.folder, "/", input$data.set), to=file)
      }
    )
  }
  shinyApp(ui=ui, server=server)
}
test.page()

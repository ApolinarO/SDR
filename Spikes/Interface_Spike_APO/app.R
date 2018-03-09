# Interface_Spike_APO
library(shiny)

# Setup
# Lists directories per year
folders.list = as.list(list.dirs("NHANES_CSV", full.names=F)[-1])
names(folders.list) = folders.list

# Gets & Groups data by year
folders.list = lapply(folders.list, function(x){
  files = list.files(file.path(".", "NHANES_CSV", x))
  names(files) = gsub("\\.\\w+", "", files)
  files
})


ui <- fluidPage(
  selectInput("year.folder", h3("Year"), choices=names(folders.list), selected=1),
  selectInput("data.set", h3("Data Set"), choices=folders.list[[1]], multiple=T),
  downloadButton("download.data", "Download")
)


server = function(input, output, session){
  # Data Set: Updates folders listed to download
  files.to.download <- eventReactive(input$data.set, {
    test = file.path(".", "NHANES_CSV", input$year.folder, input$data.set)
    print(test)
    test
  })
  
  # Input Year: Updates 'Data Set' select list
  observeEvent(input$year.folder,{
    updateSelectInput(session = session,
                      inputId = "data.set",
                      choices = folders.list[[input$year.folder]]
    )
  })
  
  # Donload Data: Generate zip file
  output$download.data <- downloadHandler(
    filename = function() { "data.zip" },
    content = function(file) { zip(zipfile=file, files=files.to.download()) }
  )
}#End Server

shinyApp(ui=ui, server=server)

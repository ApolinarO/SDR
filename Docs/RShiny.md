# R Data Project - RShiny
The application will be devloped in RShiny. RShiny provides a front end and a backedn for small web applicaitons.

RShiny is an open R session that delivers R code. When the web page changes, the r script is returned.

Input and output items are saved into a ui variable. Server functionalities are saved into a server variable, similarly to the ui variable. The application is then run and built by making a call to _shinyApp(ui, server)_.

Below is code to generate the Hello World Page: 

	ui = fluidPage("Hello World")
	server = function(input, output){}
	shinyApp(ui=ui, server=server)


Here, the server has no functionality defined. The ui is defined to only display "Hello World". These components are then put together.

Below is a sample page that generates a histogram based on a value given by a slider input: 

	ui  = fluidPage(
		sliderInput(inputId="num", label="choose a number", value=25, min=1, max=100),
		plotOutput("hist")
	)
	server = function(input, output){
		output$hist = renderPlot({
			title = paste0(input$num, " Random Numbers")
			hist(rnorm(input$num), main=title)
		})
	}
	shinyApp(ui=ui, server=server)

When looking at the assignment of the _ui_ variable, a slider input is generated through a call to _sliderInput()_. The value of that input could then be accessed by a variable identified as "num". Alongside the slider input, a space for a plot is defined in the ui.

The server defines only a single function that takes input from the slider input identified as "num" and outputs a histogram based on its results.

## Resources
 - [RShiny](http://shiny.rstudio.com/)
 - [RShiny tutorial](http://shiny.rstudio.com/tutorial/)
 - [Sample Shiny App Hosted on shinyapps.io](https://apolinaro.shinyapps.io/test1/)
More information on how we will implement automation into our program can be found alongside our [Automation Spikes](../Spikes/RShiny%20Spikes).
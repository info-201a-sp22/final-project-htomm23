# Shiny app

library(shiny)
library(markdown)
source("ui.R")
source("server.R")
library(rsconnect)

# Run the application 
shinyApp(ui = ui, server = server)

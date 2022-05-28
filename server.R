library(ggplot2)
library(plotly)
library(dplyr)

# load data

svi <- read.csv("SVI2018_US_COUNTY.csv", stringsAsFactors = FALSE)
server <- function(input, output) {
  
  output$first_plot <- renderPlotly({
    
    return(first_plot)
    
  })
  output$second_plot <- renderPlotly({

    return(second_plot)
  })
  
  output$third_plot <- renderPlotly({
    
    return(third_plot)
  })
  
}
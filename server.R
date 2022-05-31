library(ggplot2)
library(plotly)
library(dplyr)
library(usmap)
library(stringr)
library(shiny)
# load data

svi <- read.csv("SVI2018_US_COUNTY.csv", stringsAsFactors = FALSE)

avg_svi <- svi %>%
  group_by(STATE) %>% 
  filter(RPL_THEMES != -999) %>% 
  summarize(avg = mean(RPL_THEMES, na.rm = TRUE))

server <- function(input, output) {
  
  output$first_plot <- renderPlotly({
    str_to_title(avg_svi$avg)
    
    #filter by state
    states_svi <- avg_svi %>% 
      filter(STATE == input$first_visual_state)
    
    #bar chart 
    
    first_plot <- ggplot(include = c(input$first_visual_state), data = states_svi, aes(x = STATE, y = avg)) + geom_bar(stat="identity", fill = "green") + 
      labs(title = "State's Average Social Vulnerability Index (SVI)")
    
    return(first_plot)
    
  })
  output$second_plot <- renderPlotly({

    return(second_plot)
  })
  
  output$third_plot <- renderPlotly({
    # changing capitalization so R likes it
    svi$STATE = str_to_title(svi$STATE)
    # Filtering by chosen state
    third_visual_df <- svi %>% rename(fips = FIPS) %>% filter(STATE == input$third_visual_state)
    # Creating map by chosen state
    third_plot <- plot_usmap("counties", include = c(input$third_visual_state), data = third_visual_df, values = "RPL_THEMES", labels = F) +
      theme(legend.position = "right") +
      scale_fill_continuous( high = "violetred", low = "cornsilk", name = "Ranking of SVI from 0 to 1") +
      labs(title = "Counties by Social Vulnerability Index",
           subtitle = "SVI Value of 1 indicates High Vulnerability")
      
      #Display map
    return(third_plot)
  })
  
}
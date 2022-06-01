library(ggplot2)
library(plotly)
library(dplyr)
library(usmap)
library(stringr)
library(shiny)
# load data

svi <- read.csv("SVI2018_US_COUNTY.csv", stringsAsFactors = FALSE)

svi$STATE = str_to_title(svi$STATE)

avg_svi <- svi %>%
  group_by(STATE) %>% 
  filter(RPL_THEMES != -999) %>% 
  summarize(avg = mean(RPL_THEMES, na.rm = TRUE))

server <- function(input, output) {
  
  output$bar_plot <- renderPlotly({
    
    #filter by state
    states_svi <- avg_svi %>% 
      filter(STATE %in% input$first_visual_state)
    
    #bar chart 
    
    bar_plot <- ggplot(data = states_svi, aes(x = STATE, y = avg)) +
      
      geom_bar(stat="identity", fill = "green") + 
      
      labs(title = "State's Average Social Vulnerability Index (SVI)")
    
#display bar chart
return(bar_plot)
    
  })
  output$second_plot <- renderPlotly({

    return(second_plot)
  })
  
  output$third_plot <- renderPlotly({
    # changing capitalization so R likes it
    # svi$STATE = str_to_title(svi$STATE)
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
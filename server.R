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
  
  # First chart
  
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
  
  
  # Second chart  
  
    # Clean up data set
    small_svi <- svi %>%
      select("EP_POV",
             "EP_UNEMP",
             "EP_PCI",
             "EP_NOHSDP",
             "EP_AGE65",
             "EP_AGE17",
             "EP_DISABL",
             "EP_SNGPNT",
             "EP_MINRTY",
             "EP_LIMENG",
             "EP_MUNIT",
             "EP_MOBILE",
             "EP_CROWD",
             "EP_NOVEH",
             "EP_GROUPQ",
             "RPL_THEMES") %>%
      filter(RPL_THEMES != -999)

    # Graph scatter plot 
output$scatter <- renderPlot({
  
    scatter_plot <- ggplot(data = small_svi,
           mapping = aes_string(x = input$variable_selection,
                         y = "RPL_THEMES"))+
      geom_point(color = "orange")+
      labs(title = "Relationship between SVI index and selected variable",
           subtitle = "Each point represent an observation of a county",
           x = "Selected variable (rate in % and amount in US$)",
           y = "SVI index in %")+
      theme(plot.title = element_text(hjust = 0.5))
    
    return(scatter_plot)
  })
  
  # Third chart
  
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
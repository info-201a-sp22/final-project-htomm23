library(markdown)
library(plotly)
library(bslib)
library(dplyr)
library(shiny)
library(stringr)
# Load Data and CHANGED CAPITALIZATION so it looks better formatted and for map
svi <- read.csv("SVI2018_US_COUNTY.csv", stringsAsFactors = FALSE)
svi$STATE =str_to_title(svi$STATE)
#Data for state average SVIs (used for first chart only)

avg_svi <- svi %>%
  group_by(STATE) %>% 
  filter(RPL_THEMES != -999) %>% 
  summarize(avg = mean(RPL_THEMES, na.rm = TRUE))

# Determinine a Color Theme / Load Css Styling


#Front page
intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    # markdown file
    includeMarkdown("introduction_text.md"),
    # image of something for *spice*
    img(src = "image.png", height = 500, style="display: block; margin-left: auto; margin-right: auto;")
  )
)

# First visualization page
# Widget for first visual
sidebar_panel_widget1 <- sidebarPanel(
  selectInput(
    inputId = "first_visual_state",
    label = "Select State to display Average SVI",
    choices = avg_svi$avg,
    selected = "Washington",
    multiple = FALSE
  )
)

# Display First Plot / Visual
main_panel_plot1 <- mainPanel(
  plotlyOutput(outputId = "first_plot"),
  includeMarkdown("first_plot_text.md")
)
# Create First Tab
first_tab <- tabPanel(
  "First Visualization",
  sidebarLayout(
    sidebar_panel_widget1,
    main_panel_plot1
  )
)

# Second visualization page
# Widget for second visual
sidebar_panel_widget2 <- sidebarPanel(
  selectInput(
    inputId = "id",
    label = "label",
    choices = svi$COUNTY ,
    selected = "selected",
    multiple = TRUE
  )
)
# Display Second Plot / Visual
main_panel_plot2 <- mainPanel(
  plotlyOutput(outputId = "second_plot"),
  includeMarkdown("second_plot_text.md")
)


second_tab <- tabPanel(
  "Second Visualization",
  sidebarLayout(
    sidebar_panel_widget2,
    main_panel_plot2
  )
)

# Third Visualization Page
# Third Widget
sidebar_panel_widget3 <- sidebarPanel(
  selectInput(
    inputId = "third_visual_state",
    label = "Pick a state to display County SVI",
    choices = svi$STATE,
    selected = "Washington",
    multiple = F
  )
)

# Third plot / visual
main_panel_plot3 <- mainPanel(
  plotlyOutput(outputId = "third_plot"),
  includeMarkdown("third_plot_text.md")
)
# Creates third tab
third_tab <- tabPanel(
  "Third Visualization",
  sidebarLayout(
    sidebar_panel_widget3,
    main_panel_plot3
  )
)


# Conclusion tab
conclusion_tab <- tabPanel(
  "Conclusion",
  fluidPage(
    # markdown file
    includeMarkdown("conclusion_text.md")
  )
)



# Combines all tabs
ui <- navbarPage(
  # Select a Theme
 # theme = my_theme,
  # Home page title
  "Social Vulnerability",
  intro_tab,
  first_tab,
  second_tab,
  third_tab,
  conclusion_tab
)
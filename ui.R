library(markdown)
library(plotly)
library(bslib)
library(dplyr)
library(shiny)
library(stringr)
# Load Data and CHANGED CAPITALIZATION so it looks better formatted and for map
svi <- read.csv("SVI2018_US_COUNTY.csv", stringsAsFactors = FALSE)

svi$STATE = str_to_title(svi$STATE)

#Data for state average SVIs (used for first chart only)

avg_svi <- svi %>%
  group_by(STATE) %>% 
  filter(RPL_THEMES != -999) %>% 
  summarize(avg = mean(RPL_THEMES, na.rm = TRUE))

# Determinine a Color Theme / Load Css Styling
my_theme <- bs_theme(bootswatch = "minty")
# my_theme <-bs_add_rules(my_theme, sass::sass_file("style_final_project.css"))
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
    label = "Select State(s)",
    choices = avg_svi$STATE,
    selected = "Washington",
    multiple = TRUE
  )
)

# Display First Plot / Visual
main_panel_plot1 <- mainPanel(
  plotlyOutput(outputId = "bar_plot"),
  includeMarkdown("first_plot_text.md")
)
# Create First Tab
first_tab <- tabPanel(
  "Comparing State's Vulnerability",
  sidebarLayout(
    sidebar_panel_widget1,
    main_panel_plot1
  )
)

# Second visualization page
# Widget for second visual
sidebar_panel_widget2 <- sidebarPanel(
  radioButtons(
    inputId = "variable_selection",
    label = "Choose a variable to see its relationship with the SVI",
    choices = c("Below poverty rate" = "EP_POV",
                "Unemployment rate" = "EP_UNEMP",
                "Per capita income" = "EP_PCI",
                "No highschool diploma rate" = "EP_NOHSDP",
                "Age 65+ rate" = "EP_AGE65",
                "Age 17- rate" = "EP_AGE17",
                "Disabled population rate" = "EP_DISABL",
                "Single parent rate" = "EP_SNGPNT",
                "Minority population rate" = "EP_MINRTY",
                "Insufficient English population rate" = "EP_LIMENG",
                "10+ unit housing rate" = "EP_MUNIT",
                "Mobile homes rate" = "EP_MOBILE",
                "Crowded housing rate" = "EP_CROWD",
                "No vehicle rate" = "EP_NOVEH",
                "Group quarter rate" = "EP_GROUPQ"),
    selected = "EP_POV"
  )
)
# Display Second Plot / Visual
main_panel_plot2 <- mainPanel(
  plotOutput(outputId = "scatter"),
  includeMarkdown("second_plot_text.md")
)
# Create Second Tab
second_tab <- tabPanel(
  "Plotting Factors of SVI",
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
    selected = "NEW MEXICO",
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
  "Map County Visualization",
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
  theme = my_theme,
  # Home page title
  "Social Vulnerability",
  intro_tab,
  first_tab,
  third_tab,
  second_tab,
  conclusion_tab
)
# Sourcing global.R file ----
source("global.R")

# Define UI for dashboard ----
ui <- dashboardPage(
  dashboardHeader(title =  tags$b("Bike Collision in London [2005 - 2019]"),
                  titleWidth = "wide",
                  color = "grey",
                  inverted = TRUE),
  dashboardSidebar(size = "wide",
                   sidebarMenu(
                     menuItem(tabName = "home", text = "Home", icon = icon("home")),
                     menuItem(tabName = "data", text = "Data", icon = icon("table"))
                     )
                   ),
  dashboardBody(
    # Tab: Home ----
    tabItem(
      tabName = "home",
     # Input Box ----
      box( 
        title = "Inputs", title_side = "top left", width = 16,
        splitLayout(cellWidths = c("50%", "50%"),
                    selectInput("borough", "Borough", 
                                c("All", unique(collision_data$borough))),
                    selectInput("severity", "Severity", 
                                c("All", unique(collision_data$severity))))
        ),
     
     # Value Boxes ----
     valueBoxOutput("slight_value_box"),
     valueBoxOutput("serious_value_box"),
     valueBoxOutput("fatal_value_box"),
      
     # First plot - Bar chart ----
      fluidRow(
        echarts4rOutput("bar_plot")
      ), 
     # Second plot - Heat map ----
     fluidRow(
       echarts4rOutput("heat_map")
     )
      
    ),
    # Tab: Data ----
    tabItem(
      tabName = "data",
      fluidRow(
        dataTableOutput("data_table")
      )
    )
  ),
  # Disconnect message on disconnection on App ----
  disconnectMessage()
)
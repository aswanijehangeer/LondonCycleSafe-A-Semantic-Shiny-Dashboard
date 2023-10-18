# Sourcing global.R file ----
source("global.R")

# Define UI for dashboard ----
ui <- dashboard_page(
  dashboardHeader(title =  tags$b("Bike Collisions in London [2005 - 2019]"),
                  titleWidth = "wide",
                  color = "grey",
                  inverted = TRUE),
  dashboardSidebar(size = "thin",
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
        split_layout(cell_widths = c("25%, 25%, 25%, 25%"),
                                     cell_args = "padding: 6px;",
                                     style = "border: none;",
                    selectInput("borough", "Borough",
                                c("All", unique(collision_data$Borough))),
                    selectInput("severity", "Severity",
                                c("All", unique(collision_data$Severity))),
                    selectInput("ward", "Ward",
                                c("All", unique(collision_data$Ward))),
                    selectInput("type", "Casuality Type",
                                c("All", unique(collision_data$Casualties_Types))))
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
      div(
        downloadBttn("downloadData", "Download",
                     style = "simple",
                     color = "primary",
                     icon = icon("download"))
      ),
      fluidRow(
        reactableOutput("data_table")
      )
    ),
  # Disconnect message on disconnection on App ----
  disconnectMessage()
 )
)
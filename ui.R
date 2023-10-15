# Define UI for dashboard
ui <- dashboardPage(
  dashboardHeader(title =  tags$b("Bike Collision in London [2005 - 2019]"),
                  titleWidth = "wide",
                  color = "teal",
                  inverted = TRUE),
  dashboardSidebar(size = "wide",
                   sidebarMenu(
                     menuItem(tabName = "home", text = "Home", icon = icon("home")),
                     menuItem(tabName = "data", text = "Data", icon = icon("table"))
                     )
                   ),
  dashboardBody(
    # Tab: Home
    tabItem(
      tabName = "home",
     # Input Box
      box( 
        title = "Inputs", title_side = "top left", width = 16,
        splitLayout(cellWidths = c("50%", "50%"),
                    selectInput("borough", "Borough", c("All", unique(collision_data$Borough))),
                    selectInput("severity", "Severity", c("All", unique(collision_data$Severity))))
        

      ),
     # Value Boxes
      valueBox("Total", 500, width = 4, size = "large"),
      valueBox("Slight", 300, width = 4, size = "large"),
      valueBox("Serious", 100, width = 4, size = "large"),
      valueBox("Fatal", 100, width = 4, size = "large"),
      
     # First plot - Bar chart
      fluidRow(
        echarts4rOutput("bar_plot")
      ), 
     # Second plot - Heat map
     fluidRow(
       echarts4rOutput("heat_map")
     )
      
    ),
    # Tab: Data
    tabItem(
      tabName = "data",
      fluidRow(
        dataTableOutput("data_table")
      )
    )
  )
)
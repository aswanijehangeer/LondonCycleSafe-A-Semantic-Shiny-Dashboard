# Define server logic 
server <- function(input, output) {
  
  
  # Tab: Data
  output$data_table <- renderDataTable ({
    collision_data
  })
}

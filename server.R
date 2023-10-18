# Define server logic ----
server <- function(input, output, session) {
  
  # # Filtering data based on user inputs ----
  filtered_data <- reactive({
    filter_data <- collision_data
    
    # Filtering based on selected borough ----
    if (input$borough != "All") {
      filter_data <- filter_data |>
        filter(Borough == input$borough)
    }
    
    # Filtering based on selected severity ----
    if (input$severity != "All") {
      filter_data <- filter_data |>
        filter(Severity == input$severity)
    }
    
    # Filtering based on selected ward ----
    if (input$ward != "All") {
      filter_data <- filter_data |>
        filter(Ward == input$ward)
    }
    
    # Filtering based on selected casualty type ----
    if (input$type != "All") {
      filter_data <- filter_data |>
        filter(Casualties_Types == input$type)
    }
    
    return(filter_data)
  })
  
  # Updating Slight Collisions Value Box ----
  output$slight_value_box <- renderValueBox({
    values <- filtered_data()
    slight_casualties <- sum(values$Casualties[values$Severity == "slight"])
    
    valueBox(
      value = slight_casualties,
      subtitle = "Slight",
      width = 4,
      color = "teal"
    )
  })
  
  # Updating Serious Collisions Value Box ----
  output$serious_value_box <- renderValueBox({
    values <- filtered_data()
    serious_casualties <- sum(values$Casualties[values$Severity == "serious"])
    valueBox(
      value = serious_casualties,
      subtitle = "Serious",
      width = 4,
      color = "teal"
    )
  })
  
  # Updating Fatal Collisions Value Box ----
  output$fatal_value_box <- renderValueBox({
    values <- filtered_data()
    fatal_casualties <- sum(values$Casualties[values$Severity == "fatal"])
    
    valueBox(
      value = fatal_casualties,
      subtitle = "Fatal",
      width = 4,
      color = "teal"
    )
  })
  
  
  
  # Creating a bar plot based on filtered data ----
  output$bar_plot <- renderEcharts4r({
    
    filtered <- filtered_data()
    
    plot_data <- filtered |>
      group_by(Year) |>
      summarise(Collisions = sum(Casualties))
    
    # Selecting title to London if ----
    title <- if (input$borough == "All") {
      paste("Number of Casualties in London", "(", input$severity, ")")
    } else {
      paste("Number of Casualties in", input$borough, "(", input$severity, ")")
    }
    
    # Creating the bar plot ----
    plot_data |>
      e_charts(x = Year) |>
      e_bar(serie = Collisions) |>
      e_color("#00B5AD") |> 
      e_tooltip(trigger = "item") |> 
      e_legend(show = FALSE) |> 
      e_title(title, left = "center")
  })
  
  # Heat-Map ----
  output$heat_map <- renderEcharts4r({
    
    # Calculating the total number of casualties for each Year and Month ----
    heat_map_data <- filtered_data() |> 
      group_by(Year, Month) |> 
      summarise(Collisions = sum(Casualties), .groups = 'drop') 
    
    # Shiny-alert if there is no data for selected inputs
    if (nrow(heat_map_data) == 0) {
      shinyalert(
        title = "Data Not Available", 
        text = "Data is not available for the selected inputs.",
        type = "error",
        animation = TRUE,
        confirmButtonCol = "grey",
        confirmButtonText = "BACK",)
      return()
    }
    
    # Create the heat-map ----
    heat_map_data |>
      e_charts(Year) |>
      e_heatmap(Month, Collisions) |>
      e_visual_map(Collisions,
                   inRange = list(color = c("#DFFFFF", "#00B5AD", "#009A92"))) |>
      e_tooltip(trigger = "item") |>
      e_legend(show = FALSE)
  })
  
  # Tab: Data ----
  output$data_table <- renderReactable ({
    reactable(filtered_data(),
              bordered = TRUE, highlight = TRUE)
  })
  
  # Download Data Button
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(filtered_data(), con)
    }
  )
}

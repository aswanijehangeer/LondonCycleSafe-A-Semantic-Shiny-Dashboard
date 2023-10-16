# Define server logic ----
server <- function(input, output, session) {
  
  # # Filtering data based on user inputs ----
  filtered_data <- reactive({
    filter_data <- collision_data

    # Filter based on selected borough ----
    if (input$borough != "All") {
      filter_data <- filter_data |>
        filter(borough == input$borough)
    }

    # Filter based on selected severity ----
    if (input$severity != "All") {
      filter_data <- filter_data |>
        filter(severity == input$severity)
    }

    return(filter_data)
  })
  
  # Updating Slight Collisions Value Box ----
  output$slight_value_box <- renderValueBox({
    values <- filtered_data()
    slight_casualties <- sum(values$number_of_casualties[values$severity == "slight"])
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
    serious_casualties <- sum(values$number_of_casualties[values$severity == "serious"])
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
    fatal_casualties <- sum(values$number_of_casualties[values$severity == "fatal"])
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
      summarise(Collisions = sum(number_of_casualties))
    
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
      summarise(Collisions = sum(number_of_casualties), .groups = 'drop') 
    
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
  output$data_table <- renderDataTable ({
    filtered_data()
  })
}

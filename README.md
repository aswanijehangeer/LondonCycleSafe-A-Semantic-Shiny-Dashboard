# Bike Collisions in London - Shiny Semantic Dashboard

This Shiny dashboard displays information about bike collisions in London from 2005 to 2019. Users can filter the data by borough and severity to see how many collisions occurred in each category. The dashboard also displays two charts: a bar chart showing the number of collisions by year and borough, and a heat map showing the concentration of collisions by year and month.

- ### [Checkout Live Dashboard.](https://aswanijahangeer.shinyapps.io/bicycle-collisions-in-london/)

- ### [Youtube Video Link.](https://youtu.be/Ve7cJCMyW-c)

## Packages Used

- **tidyverse**: A collection of packages for data manipulation and visualization.
- **readxl**: For reading Excel files.
- **janitor**: For cleaning column names.
- **shiny**: To create interactive web applications.
- **semantic.dashboard**: For creating visually appealing dashboards.
- **shinyWidgets**: Enhances Shiny app with useful input widgets.
- **reactable**: For creating interactive and responsive tables.
- **echarts4r**: R wrapper for ECharts, a powerful charting and visualization library.
- **shinydisconnect**: For displaying a disconnect message on app disconnection.
- **shiny.semantic**: Semantic UI integration for Shiny.
- **shinyalert**: For displaying alerts in Shiny apps.

## Screenshots

### Home Tab

![Home Tab](images/Bicycle_Collisions_in_London_01.png)
![Home Tab](images/Bicycle_Collisions_in_London_02.png)

- **Inputs**: Users can select specific criteria such as Borough, Severity, Ward, and Casualty Type.
- **Value Boxes**: Display the number of casualties for different severity levels.
- **Bar Chart**: Visualizes the number of casualties over the years.
- **Heat Map**: Displays casualties by year and month.

### Data Tab

![Data Tab](images/Bicycle_Collisions_in_London_03.png)

- **Download Button**: Allows users to download the filtered data as a CSV file.
- **Data Table**: An interactive table displaying the filtered data.

### Resource

- [Bike Collisions in London (2005 - 2019)](https://bikedata.cyclestreets.net/collisions/#9.44/51.4814/0.0567)
- [Data Source: CycleStreets](https://data.world/makeovermonday/2021w31)

### Contributions

Please feel free to suggest any improvements or additional features to enhance this Shiny dashboard for a better user experience. Your feedback is highly valuable!

### License

This project is licensed under the [MIT License](LICENCE).

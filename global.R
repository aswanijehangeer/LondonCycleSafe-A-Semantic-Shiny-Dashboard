# Loading Packages

library(tidyverse)
library(readxl)
library(janitor)

library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(shinyWidgets)
library(reactable)
library(echarts4r)
library(shinydisconnect)
library(shinyalert)


# Importing data set (In data/ folder)

collision_data <- read_xlsx("data/Bike Collisions.xlsx") |> 
  clean_names()

# Giving proper names and removing unnecessary columns

collision_data <- collision_data |> 
  rename(Date = date,
         Borough = borough,
         Ward = ward,
         Latitude = latitude,
         Longitude = longitude,
         Casualties_Types = casualties,
         Severity = severity,
         URL = url,
         Casualties = number_of_casualties,
         Vehicles = number_of_vehicles) |> 
  select(Date, Borough, Ward, Latitude, Longitude, Casualties_Types, Severity, 
         URL, Casualties, Vehicles)



# Extracting Year from Date column

collision_data <- collision_data |>
  mutate(Year = as.character(year(Date)),
         Month = month(Date, label = TRUE))


# Making Date column better looking
datetime_value <- collision_data$Date

# Extracting date and time components
date_part <- gsub(" .*", "", datetime_value)
time_part <- gsub(".* ", "", datetime_value)

# Converting in a readable format
formatted_datetime <- paste(date_part, format(strptime(time_part, "%H:%M:%S"), format = "%I:%M %p"), sep = " at ")

# Adding back to collisions data frame
collision_data$Date <- formatted_datetime




















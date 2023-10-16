# Loading Packages

library(tidyverse)
library(readxl)
library(janitor)

library(shiny)
library(semantic.dashboard)
library(shinyWidgets)
library(DT)
library(echarts4r)
library(shinydisconnect)


# Importing data set (In data/ folder)

collision_data <- read_xlsx("data/Bike Collisions.xlsx") |> 
  clean_names()


# Extracting Year from Date column

collision_data <- collision_data |>
  mutate(Year = as.character(year(date)),
         Month = month(date, label = TRUE))

# collision_data |> 
#   filter(severity == 'slight') |> 
#   summarise(t = sum(number_of_casualties))
# 
# collision_data |> 
#   filter(severity == 'serious') |> 
#   summarise(t = sum(number_of_casualties))
# 
# collision_data |> 
#   filter(severity == 'fatal') |> 
#   summarise(t = sum(number_of_casualties))



# # Heat-map

# t <- collision_data |>
#   group_by(Year, Month) |>
#   summarise(tt = sum(number_of_casualties)) |>
#   ungroup()
# 
# 
#  t |>
#    e_charts(Year) |> 
#    e_heatmap(Month, tt) |>
#    e_visual_map(tt) |>
#    e_tooltip(trigger = "item") |>
#    e_legend(show = FALSE)

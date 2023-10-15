library(tidyverse)
library(readxl)

library(shiny)
library(semantic.dashboard)
library(shinyWidgets)
library(DT)
library(echarts4r)


# Importing data set (In data/ folder)

collision_data <- read_xlsx("data/Bike Collisions.xlsx")



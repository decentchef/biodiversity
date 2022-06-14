library(shiny)
library(shinydashboard)
library(dplyr)
library(leaflet)

#source("modules/counter.R")
#source("modules/leaflet.R")
df <- readr::read_csv("biodiversity-data/poland.csv")
pol <- sf::read_sf("biodiversity-data/map-data/simple_pol1.shp")


choices <- unique(df$vernacularName) %>% append(unique(df$scientificName))

library(shiny)
library(dplyr)
library(readr)
library(ggplot2)
library(jsonlite)
library(leaflet)
library(sf)
library(plotly)

df <- read_csv("biodiversity-data/poland.csv")
pol <- read_sf("biodiversity-data/map-data/simple_pol1.shp")
vue <- read_lines("www/timeline.html")
source("modules.R")
#source("modules/counter.R")
#source("modules/leaflet.R")


choices <- unique(df$vernacularName) %>% append(unique(df$scientificName))

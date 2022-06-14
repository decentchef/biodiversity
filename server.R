server <- function(input, output, session) {
      
      searchResults <- reactive({
        searchData <- df
        
        searchData <- searchData %>% filter(tolower(vernacularName) %in% tolower(input$searchText) |
                                              tolower(scientificName) %in% tolower(input$searchText))
        
        return(searchData)
      })
      
      
      output$map <- renderLeaflet({
        
        content <- paste0(
                         "<b><a href='",searchResults()$occurrenceID,"'>",
                         searchResults()$vernacularName,"</a></b>", 
                         "<br>",
                         searchResults()$scientificName
        )
        region_popup <- paste0("<strong>",
                               pol$NAME_1,
                               "</strong>")
      
        leaflet(pol) %>%
          setView(lng = 20.03560, 52.21380, zoom = 6) %>% 
          addProviderTiles("CartoDB") %>% 
          addPolygons(color = "maroon", weight = 2, smoothFactor = 0.5,
                      opacity = 1.0, fillOpacity = 0.5,
                      fillColor = "white",
                      highlightOptions = highlightOptions(color = "#eaeaea", 
                                                          weight = 2,
                                                          bringToFront = TRUE),
                      popup = region_popup
                      ) %>% 
          addMarkers(lng = ~searchResults()$longitudeDecimal, 
                     lat = ~searchResults()$latitudeDecimal,
                     popup = content)
      })
}
server <- function(input, output, session) {
      
      # search module
      updateSelectizeInput(session, 'searchText', choices = choices, server = TRUE)
      
      searchResults <- reactive({
        searchData <- df
        
        searchData <- searchData %>% filter(tolower(vernacularName) %in% tolower(input$searchText) |
                                              tolower(scientificName) %in% tolower(input$searchText))
        
        return(searchData)
      })
      
      # leaflet module
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
          setView(lng = 19.03560, 52.21380, zoom = 6) %>% 
          addProviderTiles("CartoDB") %>% 
          addPolygons(color = "maroon", weight = 1, smoothFactor = 0.5,
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
      
      # details module
      output$observations <- renderText({
        n <- nrow(searchResults())
        n <- ifelse(n == 0,"",n)
        return(n)
      })
      output$vernacular <- renderText({
        v <- searchResults()$vernacularName[1]
        v <- ifelse(is.na(v),"",v)
        return(v)
      })
      output$scientific <- renderText({
        s <- searchResults()$scientificName[1]
        s <- ifelse(is.na(s),"",s)
        return(s)
      })
}
server <- function(input, output, session) {
      
      # search module
      updateSelectizeInput(session, 'searchText', choices = choices, server = TRUE)
      
      searchResults <- reactive({
        searchData <- df
        
        searchData <- searchData %>% filter(tolower(vernacularName) %in% tolower(input$searchText) |
                                              tolower(scientificName) %in% tolower(input$searchText))
        # create csv for timeline
        searchData %>% select(scientificName, eventDate) %>% 
          group_by(eventDate) %>% 
          summarise(n = n()) %>% 
          toJSON() %>% 
          write_lines("tempSearchResult.json")
        return(searchData)
      })
      
      # leaflet module
      output$map <- renderLeaflet({
        
        content <- paste0(
                         "<b><a href='",searchResults()$occurrenceID,"'target='_blank'>",
                         searchResults()$vernacularName,"</a></b>", 
                         "<br>",
                         searchResults()$scientificName
        )
        region_popup <- paste0("<strong>",
                               pol$NAME_1,
                               "</strong>")
        
        marker <- makeAwesomeIcon(icon = 'circle', markerColor = 'red', 
                                  library='fa', 
                                  iconColor = '#eaeaea')
        
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
          addAwesomeMarkers(lng = ~searchResults()$longitudeDecimal, 
                     lat = ~searchResults()$latitudeDecimal,
                     popup = content,
                     icon = marker,
                     markerClusterOptions(spiderfyOnMaxZoom = T))
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
      # sightings module
      countResults <- reactive({
        searchResults() %>% filter(!is.na(eventTime))
      })
      output$sightings <- renderPlot({
        
        ggplot(countResults(), aes(eventTime, nrow(countResults())
                                   )) +
          geom_col(stat = "bin") +
          theme_minimal() +
          theme(axis.ticks.x = element_blank(),
                axis.ticks.y = element_blank(),
                axis.text.y = element_blank(),
                text = element_text(size = 16)) +
          ylab("Number of Sightings") +
          xlab("Time of Day")
        
      })
      # timeline module
      addResourcePath("dist", "~/biodiversity/dist/")
      output$timeline <- renderUI({
        tags$iframe(
          seamless="seamless",
          src="dist/index.html")
      })
}
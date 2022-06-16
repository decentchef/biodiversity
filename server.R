server <- function(input, output, session) {
      
      # search module
      updateSelectizeInput(session, 'searchText', choices = choices, server = TRUE)
      
      searchResults <- reactive({
        searchData <- df
        
        searchData <- searchData %>% filter(tolower(vernacularName) %in% tolower(input$searchText) |
                                              tolower(scientificName) %in% tolower(input$searchText))
        # create csv for timeline
        search <- searchData %>% select(scientificName, eventDate) %>% 
          group_by(eventDate) %>% 
          summarise(n = n()) %>% 
          toJSON() 
        
        write_lines(paste0("let searchResults  = ", search), file = "www/searchResults.js" )
        
        return(searchData)
      })
      
      # leaflet module
      leaflet_server("leaflet", search = searchResults)
      
      # details module
      details_server("details", search = searchResults)
      
      # sightings module
      sightings_server("sightings", search = searchResults)
      
      # timeline module
      timeline_server("timeline", search = searchResults)
}
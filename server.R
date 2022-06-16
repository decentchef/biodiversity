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
      leaflet_server("leaflet", search = searchResults)
      
      # details module
      details_server("details", search = searchResults)
      
      # sightings module
      sightings_server("sightings", search = searchResults)
      
      # timeline module
      timeline_server("timeline", search = searchResults)
}
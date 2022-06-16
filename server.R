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
          write_lines("~/search.json")
        return(searchData)
      })
      
      # leaflet module
      leaflet_server("leaflet", search = searchResults)
      
      # details module
      details_server("details", search = searchResults)
      
      # sightings module
      sightings_server("sightings", search = searchResults)
      
      # timeline module
      addResourcePath("dist", "~/biodiversity/dist/")
      output$timeline <- renderUI({
        tags$iframe(
          seamless="seamless",
          src="dist/index.html")
      })
}
#### details module ####
details_UI <- function(id) {
  ns <- NS(id)
  
  tagList(
    fluidPage(
      p(tags$strong("Common Name:"), 
        textOutput(ns("vernacular")) 
      ),
      p(tags$strong("Scientific Name:"), 
        textOutput(ns("scientific")) 
      ),
      p(tags$strong("Number of Observations:"), 
        textOutput(ns("observations"), inline = T) 
      )
    )
  )
}

details_server <- function(id, search) {
  moduleServer(
    id,
    function(input,output,session) {
      # details module
      output$observations <- renderText({
        n <- nrow(search())
        n <- ifelse(n == 0,"",n)
        return(n)
      })
      output$vernacular <- renderText({
        v <- search()$vernacularName[1]
        v <- ifelse(is.na(v),"",v)
        return(v)
      })
      output$scientific <- renderText({
        s <- search()$scientificName[1]
        s <- ifelse(is.na(s),"",s)
        return(s)
      })
    }
  )
}
##### #####

##### sightings module #####
sightings_UI <- function(id) {
  ns <- NS(id)
  
  tagList(
    fluidPage(
      p(tags$strong("Time of Sightings:"), 
        plotOutput(ns("sightings"),height = "225px")
      )
    )
  )
}

sightings_server <- function(id, search) {
  moduleServer(
    id,
    function(input,output,session) {
      countResults <- reactive({
        search() %>% filter(!is.na(eventTime))
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
    }
  )
}
##### #####

##### leaflet module #####
leaflet_UI <- function(id, label = "Counter") {
  ns <- NS(id)
  tagList(
    leafletOutput(ns("map"),height = "95%")
  )
}

leaflet_server <- function(id, search) {
  moduleServer(
    id,
    function(input, output, session) {
      output$map <- renderLeaflet({
        
        content <- paste0(
          "<b><a href='",search()$occurrenceID,"'target='_blank'>",
          search()$vernacularName,"</a></b>", 
          "<br>",
          search()$scientificName
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
          addAwesomeMarkers(lng = ~search()$longitudeDecimal, 
                            lat = ~search()$latitudeDecimal,
                            popup = content,
                            icon = marker,
                            markerClusterOptions(spiderfyOnMaxZoom = T))
      })
    }
  )
}
ui <- fluidPage(
  tags$head(includeCSS("styles.css")),
  titlePanel("Biodiversity in Poland"),
  fluidRow(
    column(4,
           tags$div(class = "card",
                    tags$div(class = "header", "Species Details"),
                    tags$div(class = "content",
                             selectizeInput(
                               'searchText', 'Scroll or type in species', 
                               choices = NULL, 
                               multiple = FALSE
                             ),
                             details_UI("details"),
                             hr(),
                             sightings_UI("sightings"),
                             timeline_UI("timeline")
                    )
           )
          ),
    column(8,
           tags$div(
             class = "card map",
             tags$div(class = "header", "Click on an observation for more details"),
             leaflet_UI("leaflet")
                     )
           )
  ),
  hr(),
  fluidRow(
    column(12,
           
           )
  )
)

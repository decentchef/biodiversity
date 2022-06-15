ui <- fluidPage(
  tags$head(includeCSS("styles.css")),
  titlePanel("Biodiversity in Poland"),
  fluidRow(
    column(4,
           tags$div(class = "card",
                    tags$div(class = "header", "Scroll or type in species"),
                    tags$div(class = "content",
                      selectizeInput(
                        'searchText', '', 
                        choices = NULL, 
                        multiple = FALSE
                      ),
                      hr(),
                      p(tags$strong("Common Name:"), 
                        textOutput(outputId = "vernacular") 
                      ),
                      p(tags$strong("Scientific Name:"), 
                        textOutput(outputId = "scientific") 
                      ),
                      p(tags$strong("Number of Observations:"), 
                        textOutput(outputId = "observations", inline = T) 
                      ),
                      hr(),
                      p(tags$strong("Time of Sightings:"), 
                        plotOutput("sightings",height = "225px") 
                      )
                    )
           )
          ),
    column(8,
           tags$div(
             class = "card map",
             tags$div(class = "header", "Click on an observation for more details, scroll to zoom"),
             
             leafletOutput("map",height = "95%")
                     )
           )
  )
)

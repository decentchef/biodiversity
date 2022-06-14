ui <- fluidPage(
  tags$head(includeCSS("styles.css")),
  titlePanel("Biodiversity in Poland"),
  fluidRow(
    column(4,
           tags$div(class = "card",
                    selectizeInput(
                      'searchText', 'Scroll of type in species', 
                      choices = choices, 
                      multiple = FALSE
                    ),
                    ),
           br(),
           tags$div(class = "card",
                    tableOutput("filtered_table"))
           ),
    column(8,
           tags$div(
             class = "card map",
             tags$style(type = "text/css", "#map {height: 100% !important; 
                        width: 100% !important;}"),
             leafletOutput("map", 500)
                     )
           )
  )
)

# app_bslib.R – Démo des nouveautés bslib 0.7+

# 1. Charger les librairies nécessaires
library(shiny)
library(bslib)

# 2. Interface utilisateur avec les nouvelles fonctions bslib
ui <- page_sidebar(
  title = "Démo bslib 0.7",
  sidebar = sidebar(
    numericInput("n", "Nombre d'observations", value = 100, min = 10, max = 1000),
    checkboxInput("dark", "Mode sombre", value = FALSE)
  ),
  theme = bs_theme(bootswatch = "minty"),
  card(
    width = 6,
    full_screen = TRUE,
    plotOutput("hist")
  ),
  value_box(
    title = "Nb d'observations",
    value = textOutput("n_out"),
    showcase = icon("chart-bar")
  )
)

# 3. Serveur
server <- function(input, output, session) {
  data <- reactive({
    rnorm(input$n)
  })

  output$hist <- renderPlot({
    hist(data(), col = "#69b3a2", border = "white", main = "Histogramme des données")
  })

  output$n_out <- renderText({
    input$n
  })

  # Changement de thème dynamique si checkbox cochée (optionnel)
  observe({
    if (input$dark) {
      session$setCurrentTheme(bs_theme(bootswatch = "darkly"))
    } else {
      session$setCurrentTheme(bs_theme(bootswatch = "minty"))
    }
  })
}

# 4. Lancement de l'app
shinyApp(ui, server)

# app_bslib.R – Démo des nouveautés bslib 0.7+ avec les données `penguins`

# 1. Charger les librairies nécessaires
library(shiny)
library(bslib)
library(dplyr)
library(palmerpenguins)
library(ggplot2)
library(DT)
library(tidyr)  # drop_na est ici

# 2. Interface utilisateur enrichie
ui <- page_sidebar(
  title = "Exploration des manchots avec bslib",
  sidebar = sidebar(
    selectInput("species", "Espèce à visualiser", choices = unique(penguins$species), selected = unique(penguins$species)[1]),
    selectInput("xvar", "Variable X", choices = names(penguins)[sapply(penguins, is.numeric)], selected = "bill_length_mm"),
    selectInput("yvar", "Variable Y", choices = names(penguins)[sapply(penguins, is.numeric)], selected = "bill_depth_mm"),
    checkboxInput("dark", "Mode sombre", value = FALSE),
    checkboxGroupInput("sex", "Sexe", choices = c("male", "female"), selected = c("male", "female"))
  ),
  theme = bs_theme(bootswatch = "minty"),
  layout_columns(
    card(
      full_screen = TRUE,
      plotOutput("scatter")
    ),
    card(
      full_screen = TRUE,
      dataTableOutput("summary")
    )
  ),
  layout_columns(
    value_box(
      title = "Nombre total",
      value = textOutput("count"),
      showcase = icon("dove")
    ),
    value_box(
      title = "Espèce sélectionnée",
      value = textOutput("selected_species"),
      showcase = icon("feather")
    ),
    value_box(
      title = "Variables X & Y",
      value = textOutput("vars_selected"),
      showcase = icon("arrows-alt")
    )
  )
)

# 3. Serveur
server <- function(input, output, session) {
  data_filtered <- reactive({
    penguins %>% 
      filter(species == input$species, sex %in% input$sex) %>%
      tidyr::drop_na(.data[[input$xvar]], .data[[input$yvar]])
  })
  
  output$scatter <- renderPlot({
    ggplot(data_filtered(), aes_string(x = input$xvar, y = input$yvar, color = "island")) +
      geom_point(size = 3, alpha = 0.8) +
      theme_minimal() +
      labs(title = paste("Scatterplot -", input$species), color = "Île")
  })
  
  output$summary <- renderDataTable({
    data_filtered() %>% 
      group_by(island) %>%
      summarise(
        Min_X = min(.data[[input$xvar]], na.rm = TRUE),
        Mediane_X = median(.data[[input$xvar]], na.rm = TRUE),
        Moyenne_X = mean(.data[[input$xvar]], na.rm = TRUE),
        Max_X = max(.data[[input$xvar]], na.rm = TRUE),
        Min_Y = min(.data[[input$yvar]], na.rm = TRUE),
        Mediane_Y = median(.data[[input$yvar]], na.rm = TRUE),
        Moyenne_Y = mean(.data[[input$yvar]], na.rm = TRUE),
        Max_Y = max(.data[[input$yvar]], na.rm = TRUE),
        .groups = "drop"
      ) %>%
      datatable()
  })
  
  output$count <- renderText({
    nrow(data_filtered())
  })
  
  output$selected_species <- renderText({
    input$species
  })
  
  output$vars_selected <- renderText({
    paste(input$xvar, "/", input$yvar)
  })
  
  # Thème dynamique
  observe({
    if (input$dark) {
      session$setCurrentTheme(bs_theme(bootswatch = "darkly"))
    } else {
      session$setCurrentTheme(bs_theme(bootswatch = "minty"))
    }
  })
}

# 4. Lancement
shinyApp(ui, server)
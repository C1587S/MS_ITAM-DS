packages <- c('shiny', 'ggvis', 'tidyverse')
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(shiny)
require('ggvis')
source('utils.R')

regiones <- get_regions()
anios <- get_years()


fluidPage(
  titlePanel("Gapminder Shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Region", "Region", regiones, choices=as.list(regiones), multiple=FALSE), # multiple es para seleccionar varias opciones al tiempo
      selectInput("year", "Año", anios, choices=c(anios), multiple=FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Estadísticas descriptivas", verbatimTextOutput("summary")),
        tabPanel("Box-Plot", plotOutput("boxplot")), 
        tabPanel("Gráfica de los datos", ggvisOutput("ggvis")),
        tabPanel("Regresión lineal", verbatimTextOutput("regresion"),
        tabPanel("Análisis de residuos", plotOutput("residuos_plot"))
    )
  )
)
)



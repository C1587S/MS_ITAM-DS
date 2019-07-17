
#resource('preliminares_paso1.R')
regiones_menu <- na.omit(unique(big_db_nona$region))



# UI ---------------------------------------------------------------------------
ui <- pageWithSidebar(
    
    # Title ----
    headerPanel("Visualización de datos y regresión lineal simple usando interfaz gráfica"),
    
    # Sidebar ----
    sidebarPanel(
 
        helpText("Esta aplicación toma como base los datos descargados en el script 'preliminares.R', en el cual se crear una sub-base de datos de los índice de desarrollo económico del banco mundial (WDI) para luego generar un motionchart con ggooglevis."),
        br()
        ),
    
    # Main panel ----
    mainPanel(
        tabsetPanel(

            tabPanel("Visualización de base de datos dinámica", htmlOutput("plot_1"))
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
  
    
    
    output$plot_1 <- renderGvis({
        plot_1<- gvisMotionChart(big_db_cln,
                                 idvar = "country",
                                 timevar = "year",
                                 xvar = "",
                                 yvar = "",
                                 sizevar ="Poblacion_total",
                                 colorvar = "region")
        
    })
    
    
}


# Run the application 
shinyApp(ui = ui, server = server)

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
    
        reactive_df <- reactive({
            big_db_nona %>%
            group_by(region) %>%
            filter(year==input$year) 
    })
        vax_reac <- reactive({x<-input$varx})
        vay_reac <- reactive({y<-input$vary})
    
    output$tabla_sum <- renderPrint({
        sub_set <- reactive_df()
        head(sub_set)
    })
    
    output$estad_x <- renderPrint({
        sub_set <- reactive_df()
        varx <- vax_reac()
        subset %>% summarise(prom_as = mean(Pib_per_capita_real), na.rm = T,
                  Desvest_as = sd(Pib_per_capita_real), na.rm = T,
                  Min_as = min(Pib_per_capita_real), na.rm = T,
                  Mediana_as = median(Pib_per_capita_real), na.rm = T,
                  Max_as = max(Pib_per_capita_real), na.rm = T,
                  Total_as = n())
    })    
    

    
    

    lmResults <- reactive({
        regress.exp <- "y~x"
        lm(regress.exp, data=mydata())
    })
    
    # Show plot of points, regression line, residuals
    output$scatter <- renderPlot({
        sub_set <- reactive_df()
        
        ggplot(sub_set, aes(input$varx, input$vary)) + 
            geom_point(color='#2980B9', size = 4) + 
            geom_smooth(method=lm, color='#2C3E50')
        

    })
    
    output$residuals <- renderPlot({

    }, height=280 )
    
    
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

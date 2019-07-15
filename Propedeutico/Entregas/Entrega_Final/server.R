packages <- c('shiny', 'ggvis', 'tidyverse')
new.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


library(shiny)
library(ggplot2)
require('ggvis')
source('utils.R')

joined_df <- load_data()

function(input, output) {
  reactive_df <- reactive({
    subset_year <- joined_df[joined_df$year == input$year, ]
    subset_region <- subset_year[subset_year$Region %in% input$Region, ]
    subset_population <- subset_region[subset_region$population %in% input$Region, ]
    subset_region
    
  }) 
  
  vis <- reactive({
    subset_df <- reactive_df()
    ggvis(subset_df, ~life, ~fert_rate, fill=~Region, opacity := 0.75) %>%
      layer_points(key := ~Country.Name, size := ~pop/5e5) %>%
      scale_numeric("x", domain = c(10, 90), nice = FALSE, clamp = TRUE) %>%
      scale_numeric("y", domain = c(0.5, 9), nice = FALSE, clamp = TRUE) %>%
      add_axis("x", title = "Birth Rate") %>%
      add_axis("y", title = "Life Expectancy") %>%
      add_tooltip(function(data){
        paste0("Country: ", data$Country.Name, "<br>", 
               "Population: ", data$pop, "<br>",
               "Region: ", data$Region, "<br>",
               "Life Expectancy: ", data$life, "<br>",
               "Fertility Rate: ", data$fert_rate, "<br>")
      }, "hover") %>%
      hide_legend("size")
  })
  
  vis %>% bind_shiny("ggvis", "ggvis_ui")
  
  ## Acá se añade una tabla de resúmen de las estadísticas descriptivas para la región seleccionada
  output$summary <- renderPrint({
    small_subset <- subset(joined_df, Region==input$Region & year== input$year,)
    subset_table <- group_by(small_subset, Region)
    summarize(subset_table, count = n(),
                           sd = sd(life, na.rm = T),
                           Min = min(life, na.rm = T),
                           q1 = quantile(life, 0.25, na.rm = T),
                           mediana = median(life, na.rm = T),
                           promedio = mean(life, na.rm = T),
                           q3 = quantile(life, 0.75, na.rm = T),
                           Max = max(life, na.rm = T))
  })

# Acá ponemos los box plots por region
  output$boxplot <- renderPlot({
    small_subset <- subset(joined_df, Region==input$Region & year== input$year,)
    ggplot(small_subset, aes(x = Region, y = life)) +
      geom_boxplot(outlier.colour = "hotpink") +
      geom_jitter(position = position_jitter(width = 0.1, height = 0), alpha = 1/4)
  })
   
# Acá vamos a hacer la regresión y análisis de residuos de la misma
    output$regresion <- renderPrint({
    small_subset <- subset(joined_df, Region==input$Region & year== input$year,)
    subset_table <- group_by(small_subset, Region)
    linear_reg <- lm(life~fert_rate, data=subset_table)
    summary(linear_reg)
  })  
    

## análisis de residuos
    output$residuos_plot <- renderPlot({
      small_subset <- subset(joined_df, Region==input$Region & year== input$year,)
      subset_table <- group_by(small_subset, Region)
      linear_reg <- lm(life~fert_rate, data=subset_table)
      
      layout(matrix(c(1,1,2,3),2,2,byrow=T))
      #Spend x Residuals Plot
      plot(linear_reg$resid~data_reg$fert_rate[order(data_reg$fert_rate)],
      main="Spend x Residuals\nfor Simple Regression",
      xlab="Marketing Spend", ylab="Residuals")
      abline(h=0,lty=2)
      #Histogram of Residuals
      hist(linear_reg$resid, main="Histogram of Residuals",
      ylab="Residuals")
      #Q-Q Plot
      qqnorm(linear_reg$resid)
      qqline(linear_reg$resid)
    })
}


#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(plotly)

dados = read_csv(file = "series_from_imdb.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$distPlot <- renderPlotly({
    
    serie <- paste(input$series)
    
    if (length(serie) >= 1) {
      dados = dados %>% filter(series_name == serie, season == 1) 
      dados %>%
        ggplot(aes(x = UserRating)) + 
        geom_histogram(binwidth = .5, fill = "blue", color = "black") + 
        geom_rug() +
        labs(title = "Classificação do usuário durante a primeira temporada", 
             x = "Classificação do usuário", 
             y = "Frequência")
    }
    
    
    #str_series <- paste(toString(input$series), collapse = ", ")
    
    #if(str_series != "") {
      
    #  print("Entrou no if...")
    #  print(str_series)
      
    #  for(serie in c(str_series)) {
        
    #    str <- paste(serie) 
        
    #    print(str)
        
    #    dados = dados %>% filter(series_name == str, season == 1) 
    #    dados %>%
    #      ggplot(aes(x = UserRating)) + 
    #      geom_histogram(binwidth = .5, fill = "blue", color = "black") + 
    #      geom_rug() +
    #      labs(title = "Classificação do usuário durante a primeira temporada", 
    #           x = "Classificação do usuário", 
    #           y = "Frequência")
        
    #  }
      
    #}
  
  
  })
  
  output$txt <- renderText({
    serie <- paste(input$series, collapse = ", ")
    paste("Você escolheu: ", serie)
  })
  
})

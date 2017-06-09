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
      
      dados <- dados %>% filter(series_name %in% input$series, season == 1)
      
      if(length(input$series) >= 1) {
        dados %>%
          ggplot(aes(x = season_ep, 
                     y = UserRating)) + 
          geom_line() + 
          geom_point(aes(text = paste("Episódio:", season_ep, "<br>", "Classificação:", UserRating)), 
                     color = "blue", 
                     size = 2) +
          scale_x_continuous(breaks=seq(1, 25, 5))+
          facet_wrap(~series_name, scales = "free_x") +
          labs(title = "Classificação do usuário ao longo da nona temporada de HIMYM", x = "Episódio", y = "Classificação do usuário") %>% return()  
      } else {
        dados %>%
          ggplot(aes(x = UserRating)) + 
          geom_histogram(binwidth = .5, fill = "blue", color = "black") + 
          geom_rug() +
          labs(title = "Classificação do usuário ao longo da nona temporada de HIMYM", x = "Episódio", y = "Classificação do usuário") %>% return()
      }
    })
    
    output$txt <- renderText({
      serie <- paste(input$series, collapse = ", ")
      paste("Você escolheu: ", serie)
    })
  
})

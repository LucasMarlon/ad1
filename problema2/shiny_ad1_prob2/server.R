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

# Define server logic required to draw a graphic
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlotly({
      
      dados = dados %>% filter(series_name %in% input$series, season == 1)
      
      if (input$tipo == "linhas") { #Visualização com gráficos de linhas
        
        p <- dados %>%
          ggplot(aes(x = season_ep, 
                     y = UserRating)) + 
          geom_line() + 
          geom_point(aes(text = paste("Episódio:", season_ep, "<br>", "Classificação:", UserRating)), 
                     color = "red", 
                     size = 1.0) +
          scale_y_continuous(breaks= seq(7, 10, .5)) +
          scale_x_continuous(breaks = seq(1, 25, 5)) +
          xlab("Episódio") + 
          ylab("Classificação do usuário") +
          ggtitle("Classificação do usuário ao longo da 1ª temporada")
        
        if (length(input$series) == 2) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x", nrow = 2, ncol = 1)
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=50), 
                   width = "1000px", height="600px") %>% return()
        } else if(length(input$series) == 3) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x", nrow = 2, ncol = 2)
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=50), 
                   width = "1000px", height="600px") %>% return()
        } else if(length(input$series) >= 1) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x")
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=70), 
                   width = "1000px", height="600px") %>% return()
        } else {
          p <- dados %>%
            ggplot(aes(x = UserRating)) +
            geom_histogram(binwidth = .5, fill = "blue", color = "black") +
            geom_rug() +
            xlab("Episódio") + 
            ylab("Classificação do usuário") +
            ggtitle("Classificação do usuário ao longo da 1ª temporada")
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=70),
                   width = "1000px", height="600px") %>% return()
        }
        
      } else { #Visualização com gráficos de barras
        
        p <- dados %>%
          ggplot(aes(x = UserRating)) + 
          geom_histogram(binwidth = .5, fill = "blue", color = "black") + 
          geom_rug() +
          facet_wrap(~series_name, scales = "free_x") +
          scale_x_continuous(breaks = seq(7, 10, .5)) +
          xlab("Classificação do usuário") + 
          ylab("Frequência") +
          ggtitle("Frequência da classificação dos usuários durante a 1ª temporada")
        
        if (length(input$series) == 2) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x", nrow = 2, ncol = 1)
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=50), 
                   width = "1000px", height="600px") %>% return()
        } else if(length(input$series) == 3) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x", nrow = 2, ncol = 2)
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=50), 
                   width = "1000px", height="600px") %>% return()
        } else if(length(input$series) >= 1) {
          
          p <- p + facet_wrap(~series_name, scales = "free_x")
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=70), 
                   width = "1000px", height="600px") %>% return()
        } else {
          p <- dados %>%
            ggplot(aes(x = UserRating)) +
            geom_histogram(binwidth = .5, fill = "blue", color = "black") +
            geom_rug() +
            xlab("Classificação do usuário") + 
            ylab("Frequência") +
            ggtitle("Frequência da classificação dos usuários durante a 1ª temporada")
          
          ggplotly(p, tooltip = "text") %>%
            layout(margin=list(r=100, l=70, t=-10, b=70),
                   width = "1000px", height="600px") %>% return()
        }
        
      }
      
    })
  
})

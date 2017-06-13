#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Avaliando a 1ª Temporada"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("series", "Escolha as séries:",
                         choiceNames =
                           list("13 Reasons Why", 
                                "Friends",
                                "Grey’s Anatomy",
                                "How I Met Your Mother", 
                                "Modern Family",
                                "Once Upon a Time",
                                "Sherlock",
                                "Sense8",
                                "Stranger Things",
                                "The 100"),
                         choiceValues =
                           list("13 Reasons Why", 
                                "Friends",
                                "Grey’s Anatomy",
                                "How I Met Your Mother", 
                                "Modern Family",
                                "Once Upon a Time",
                                "Sherlock",
                                "Sense8",
                                "Stranger Things",
                                "The 100")
      ),
      radioButtons("tipo", "Escolha o tipo de visualização: ",
                   choiceNames = list(
                     "Gráfico de linhas",
                     "Gráfico de barras"
                   ),
                   choiceValues = list(
                     "linhas", "barras"
                   ))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Qual das séries possui melhor avaliação na 1ª temporada?"),
      p("Vamos investigar como se comportou a avaliação dos usuários durante a 1ª temporada das séries. 
        Ao lado você pode escolher as séries que preferir para observar qual delas obteve melhor avaliação. Além disso você também pode escolher o tipo de visualização dos dados."),
      p("Para nos ajudar a responder essa pergunta vamos observar e analisar os gráficos abaixo:"),
      plotlyOutput("distPlot")
    )
  )
))

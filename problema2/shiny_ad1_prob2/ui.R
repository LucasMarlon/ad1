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
      textOutput("txt")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h2("Qual das séries possui maior avaliação na 1ª temporada?"),
      p("Vamos investigar como se comportou a avaliação dos usuários durante a 1ª temporada das séries. 
        Ao lado você pode escolher as séries que preferir e observar qual delas obteve melhor avaliação."),
      p("Para responder essa pergunta vamos olhar para os gráficos que representam a curva de avaliação de todos os episódios das séries."),
      plotlyOutput("distPlot")
    )
  )
))

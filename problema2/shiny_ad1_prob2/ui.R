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
                                "How I Met Your Mother", 
                                "Modern Family",
                                "Once Upon a Time",
                                "Sherlock",
                                "Sense8",
                                "Stranger Things"),
                         choiceValues =
                           list("13 Reasons Why", 
                                "Friends", 
                                "How I Met Your Mother", 
                                "Modern Family",
                                "Once Upon a Time",
                                "Sherlock",
                                "Sense8",
                                "Stranger Things")
      ),
      textOutput("txt")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      plotlyOutput("distPlot")
      
    )
  )
))

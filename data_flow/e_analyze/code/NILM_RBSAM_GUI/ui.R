library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("NILM to RBSAM Comparisons"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("source", label = h3("Select Source"), 
                  choices = list("belkin"="belkin","enetics"="enetics","plotwatt"="plotwatt"), 
                  selected = "enetics"),
      htmlOutput("selectSite"),
      htmlOutput("selectEnduses"),
      htmlOutput("selectStart"),
      
      
      
      
      sliderInput("start_ind","Starting Index:",min = 0,max = 1,value = 0,step=.0001,animate=TRUE),
      
      
#       sliderInput("obs","Minutes",min = 10,max = 10080,value = 120,step=15,animate=TRUE),
      numericInput("obs", label = h3("Observations"), value = 60),
      sliderInput("vert_bar","Vertical Bar",min = 0,max = 1,value = 0,animate=TRUE),
      
      tags$head(
        tags$style("body {background-color: black; }")
      )
      
      
      
    ),
    
    
    
    
    mainPanel(
      plotOutput("plot_gui")
    )
  )
)
)
# 
# install.packages('devtools')
# devtools::install_github('rstudio/shinyapps')
# shinyapps::setAccountInfo(name='ecotope', 
#                            token='B8D715FA18EC13DBC44B3F643885D857', 
#                            secret='cnC+0Vfr/tOhfg7F30H9RYHsnLtpt3ZnJFeDjATs')
#  library(shinyapps)
#remember to set proper working directory
#  shinyapps::deployApp()
#


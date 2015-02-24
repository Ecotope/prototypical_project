library(shiny)
source("./dhpCycling_gui.R")
shinyUI(fluidPage(
  
  # Application title
  titlePanel("dhp Cycling"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Site", label = h3("Select Site"), 
                  choices = list("31191" = 31191,"33406" = 33406,"33462" = 33462,"33576" = 33576,"29805" = 29805,
                                 "33409" = 33409,"10012" = 10012,"30249" = 30249,"32373" = 32373,"33408" = 33408,
                                 "29584" = 29584,"28935" = 28935,"10010" = 10010,"40001" = 40001,"40002" = 40002,
                                 "40003" = 40003,"20001" = 20001), 
                  selected = 20001),
      sliderInput("start_ind","Starting Index:",min = .01,max = 1,value = 0,step=.0001,animate=TRUE),
      sliderInput("obs","Minutes",min = 10,max = 10080,value = 120,step=15,animate=TRUE),
      sliderInput("vert_bar","Vertical Bar",min = 0,max = 1,value = 0,animate=TRUE),
      checkboxGroupInput("TempVars", label = h3("Temperature Variables"), 
                         choices = list("OAT"="OAT","living.room"="Living.Room")),
      checkboxGroupInput("PowerVars", label = h3("Power Variables"), 
                         choices = list("DHP" = "DHP"),
                         selected = c("DHP"))
      
      
    ),
    
    
    
    
    mainPanel(
      plotOutput("dhpCycling_gui")
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


library(shiny)

source("./dhpCycling_gui.R")

shinyServer(function(input, output) {
  
  
  
  output$dhpCycling_gui <- renderPlot({
    
    start_ind=input$start_ind
    obs=input$obs
    vert_bar=input$vert_bar
    PowerVars=input$PowerVars
    TempVars=input$TempVars
    Site=input$Site
    dhpCycling_gui(Site,start_ind,obs,vert_bar,PowerVars,TempVars)    
  })
  
  
})



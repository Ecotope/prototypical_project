library(shiny)



shinyServer(function(input, output) {
  #generating site choices based on source selection
  searchSite<- reactive({
    sites=try(levels(as.factor(site_info$siteid[which(site_info$source==input$source)])),silent=TRUE)
  })
  output$selectSite <- renderUI({ 
    selectInput("site", label = h3("Select Site"), searchSite() )
  })
  #generating variable choices based on site selection
  searchVar<- reactive({
    r_name=paste0("RBSAM_",input$source,"_",input$site)
    n_name=paste0(input$source,"_",input$site)
    
#     r_list_ind=try(intersect(grep(names(GUI_list),pattern=paste(input$site)),
#                    grep(names(GUI_list),pattern=paste("RBSAM")),
#                    grep(names(GUI_list),pattern=paste(input$source))),
#                    silent=TRUE)
#     names(GUI_list)[r_list_ind]
#     n_list_ind=try(setdiff(intersect(grep(names(GUI_list),pattern=paste(input$site)),
#                           grep(names(GUI_list),pattern=paste(input$source))),r_list_ind),
#                            silent=TRUE)
#     names(GUI_list)[n_list_ind]
  enduses=try(intersect(names(GUI_list[[r_name]]),names(GUI_list[[n_name]])),silent=TRUE)
  })
output$selectEnduses <- renderUI({ 
  try(checkboxGroupInput("enduses", label = h3("Select End Use"), searchVar(),selected=searchVar()[1] ),silent=TRUE)
})




output$plot_gui <- renderPlot({
  start_ind=input$start_ind
  obs=input$obs
  vert_bar=input$vert_bar
  enduses=input$enduses
  site=input$site
  source=input$source
  plot_gui(site,source,start_ind,obs,vert_bar,enduses)    
})



})



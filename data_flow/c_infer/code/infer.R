source("E:/R/cdx.R")
cdx("dhpCycling")
site_info=read.csv("./site_info.csv")




for (site in site_info$siteid){
  print(paste0("Inferring site: ",site))
  load(paste0("./b_clean/data/deliverable/",site,".rda"))
  
  #program some stuff here
  

  
  save(file002,file=paste0("./c_infer/data/deliverable/",site,".rda"))
  save(file002,file=paste0("./e_analyze/code/dhpCycling_gui/",site,".rda"))
}


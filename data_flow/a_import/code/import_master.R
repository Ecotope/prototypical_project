

cdx("project")
file_drops=list.files("./a_import/data/client_provided_data/")
site_info=read.csv("./site_info.csv")
variable_alias_ref=read.csv("./a_import/data/variable_alias_ref.csv")


#format files from each file drop
for (drop in file_drops){
  print(paste0("Processing drop: ",drop))
  source(paste0("./a_import/code/import_raw_",drop,".R"))
  source(paste0("./a_import/code/ids_codes_raw_",drop,".R"))
}

#Accumulating for deliverable
for (site in site_info$siteid){
  print(paste0("Accumulating site: ",site))
  file002=NULL
  for (drop in file_drops){
    catch=try(load(paste0("./a_import/data/client_provided_data/",drop,"/formatted/",site,".rda")), silent=TRUE)
    if (class(catch)=="try-error") next
    file002=rbind(file001,file002)
  }  
  
  save(file002,file=paste0("./a_import/data/deliverable/",site,".rda"))
}



file002=NULL
for (drop in file_drops){
  catch=try(load(paste0("./a_import/data/client_provided_data/",drop,"/formatted/ids_codes_raw",drop,".rda")),silent=TRUE)
  if (class(catch)=="try-error") next
  file002=rbind.all.columns(file002,file001)  
  
}
rownames(file002)=NULL
write.csv(file002,"./ids_codes_raw.csv")



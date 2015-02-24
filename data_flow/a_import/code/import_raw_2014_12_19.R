#import_raw_2014_12_19.R

setwd("./a_import/data/client_provided_data/2014_12_19/raw")



sites_n=dim(site_info)[1]

for (i in 1:sites_n){
  print(site_info$siteid[i])
  site_grep=as.character(site_info$DHP[i])
  siteFiles=list.files(pattern=site_grep)
  if (length(siteFiles)==0) next
  file001=data.frame()
  count=0
  countlist1=NULL
  for (file in siteFiles){
    #    print(file)
    count=count+1
    tmpfile=try(read.csv(paste0("./",file),skip=8))
    if("try-error" %in% class(tmpfile)) {
      countlist1=c(countlist1,count) 
      next
    }
    
    
    #kill variable with only NA values
    rows=dim(tmpfile)[1]
    NA_inds=NULL
    for (j in 1:dim(tmpfile)[2]) {
      x=as.numeric(summary(tmpfile[,j])[2])
      if (mode(tmpfile[,j])=="logical" & x==rows){
        NA_inds=c(NA_inds,j)
      }
    }
    if (length(NA_inds)){
      tmpfile=tmpfile[,-NA_inds]
    }
    
    
    #  fix some names
    null_inds=NULL
    rename_ind=which(names(tmpfile) %in% variable_alias_ref$variable.alias)
    for (ind in rename_ind){
      rename_to_ind=which(variable_alias_ref$variable.alias==names(tmpfile)[ind])
      if (variable_alias_ref$variable.true[rename_to_ind]=="NULL")  {
        null_inds=c(null_inds,ind)
      } else {
        names(tmpfile)[ind]=as.character(variable_alias_ref$variable.true[rename_to_ind])
      }
    }
    if (length(null_inds))  tmpfile=tmpfile[,-null_inds]
    
    file001=rbind.all.columns(file001,tmpfile)  
  }
  
  if (length(countlist1)) {
    print("Errors on files:")
    print(siteFiles[countlist1])
  }
  file001$Date.Time=as.POSIXct(file001$Date.Time, format="%m/%d/%Y %H:%M",tz="GMT")
  save(file001,file=paste0("../formatted/",site_info$siteid[i],".rda"))
}
cdx("dhpCycling")











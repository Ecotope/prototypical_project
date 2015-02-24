#ids_codes_raw_2014_12_19.R

setwd("./a_import/data/client_provided_data/2014_12_19/raw")
drop_date="2014_12_19"


sites_n=dim(site_info)[1]
file001=data.frame()

for (i in 1:sites_n){
  site_grep=as.character(site_info$DHP[i])
  siteFiles=list.files(pattern=site_grep)
  if (length(siteFiles)==0) next
  
  count=0
  countlist1=NULL
  
  for (file in siteFiles){
#     print(file)
    count=count+1
    tmpfile=try(read.csv(paste0("./",file),skip=8))
    if("try-error" %in% class(tmpfile)) {
      file.rename(from=paste0("./",file),to=paste0("./bad/",file))
      countlist1=c(countlist1,count) 
      next
    }
    
    tmp_names=names(tmpfile)
    
    tmp_start=as.character(tmpfile$Date.Time[1])
    tmp_end=as.character(tmpfile$Date.Time[dim(tmpfile)[1]])
    
    tmp_vec=NULL
    tmp_vec=as.data.frame(tmp_vec)
    tmp_vec1=c(site_info$siteid[i],drop_date,file,tmp_start,tmp_end)
    tmp_vec=rbind(tmp_vec,tmp_vec1)
    names(tmp_vec)=c("site","drop_date","file_name","file_start","file_end")
   
    tmp_vec[,tmp_names]=1
 

    file001=rbind.all.columns (file001,tmp_vec)  
  }
  
  
  
}

save(file001,file=paste0("../formatted/ids_codes_raw",drop_date,".rda"))
cdx("project")









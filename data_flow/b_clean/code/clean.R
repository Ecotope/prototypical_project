source("E:/R/cdx.R")
cdx("dhpCycling")
site_info=read.csv("./site_info.csv")
bad_data=read.csv("./b_clean/data/bad_data.csv")
var_ranges=read.csv("./b_clean/data/var_ranges.csv")


for (site in site_info$siteid){
  print(paste0("Cleaning site: ",site))
  bad_data_sub=bad_data[which(bad_data$siteid==site),]
  load(paste0("./a_import/data/deliverable/",site,".rda"))
  
  bad_n=dim(bad_data_sub)[1]
  
  for (i in 1:bad_n){
    #program some stuff here
    
    
  }

  #remove observations that are missing all but time variable
  NA_obs <- apply(file002, 1,function(x){sum(is.na(x))==(ncol(file002)-1)})
  if (sum(NA_obs)>0) file002=file002[!NA_obs,]
  rownames(file002)=NULL
  # forcing variables ranges
  irrelevant_ranges <- apply(var_ranges, 1,function(x){sum(is.na(x))==2})
  var_ranges=var_ranges[!irrelevant_ranges,]
  rel_ind=which(names(file002) %in% var_ranges$variable.true)
  for (ind in rel_ind){
    ind2=which(var_ranges$variable.true==names(file002)[ind])
    low_ind=which(file002[,ind]<var_ranges$min.allowed[ind2])
    if (length(low_ind)>0) file002[low_ind,ind]=NA
    high_ind=which(file002[,ind]>var_ranges$max.allowed[ind2])
    if (length(high_ind)>0) file002[high_ind,ind]=NA
  }
  

  save(file002,file=paste0("./b_clean/data/deliverable/",site,".rda"))
}



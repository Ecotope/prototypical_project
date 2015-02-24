source("E:/R/cdx.R")

cdx("dhpCycling")
site_info=read.csv("./site_info.csv")




for (site in site_info$siteid){
  print(paste0("Imputing site: ",site))
  load(paste0("./c_infer/data/deliverable/",site,".rda"))
  
  #mean imputation for single NA observations
  file002[,2:dim(file002)[2]]=apply(file002[,2:dim(file002)[2]],2,function(x){
    na_ind=which(is.na(x))
    if (length(na_ind)==0) try(next, silent=TRUE)
    for (j in na_ind){
      if (j==1 | j==length(x)) try(next, silent=TRUE)
      if (is.na(x[j-1]) | is.na(x[j+1])) try(next, silent=TRUE)
      hold=try(mean(c(x[j-1],x[j+1])))
      if (class(hold)!="try-error") x[j]=hold
      
    }
    return(x)
  }
  )
  
  save(file002,file=paste0("./d_impute/data/deliverable/",site,".rda"))
}





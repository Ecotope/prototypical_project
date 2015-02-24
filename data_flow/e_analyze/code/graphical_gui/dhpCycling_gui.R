
color_ref=read.csv("./color_ref.csv")


dhpCycling_gui=function(Site,start,obs,vert_bar,PowerVars,TempVars) {
  
  load(file=paste0("./",Site,".rda"))
  data=file002
  start=round(start*nrow(data))
  
  vert_bar=vert_bar*obs
  plotsplit=0
  #check validity of entries
  temp_ind=which(names(data) %in% TempVars)
  if (length(temp_ind)>0) plotsplit=plotsplit+1
  
  power_ind=which(names(data) %in% PowerVars)
  if (length(power_ind)>0) plotsplit=plotsplit+1
  
  
  #getting range
  finish=start+obs
  this_span=seq(start,finish)
  #establishing plotting parameters  
  par(mfrow=c(plotsplit,1),pty="m",mar=c(4, 15, 2,1),oma=c(5,0.1,1,1),xpd=TRUE) 
  
  #power plot
  if (length(power_ind)>0) {
    try(sub_routine(ind=power_ind,data=data,this_span=this_span,ylab="Watts",
                inset=c(-0.32,0),vert_bar=vert_bar,range_round=100))
    
      title(paste0(Site," Starting on: ",data[start,1]))
  
  }
  
  #temperature plot
  if (length(temp_ind)>0) {
    try(sub_routine(ind=temp_ind,data=data,this_span=this_span,ylab="Fahrenheit",
                inset=c(-0.32,0),vert_bar=vert_bar,range_round=20))
  }
  title(xlab="Minutes")
  
}




sub_routine=function(ind,data,this_span,ylab,inset,vert_bar,range_round) { 
  legend_ind=ind
  for (j in ind){
    if (sum(is.na(data[this_span,j]))==length(this_span)) {
      legend_ind=legend_ind[-which(legend_ind==j)]
      try(next, silent=TRUE)
    }
  }
  #find plot range
  a=data[this_span,legend_ind]
  if (length(legend_ind)>1) {
    ymax=ceiling(max(apply(a,2,function(x){max(na.omit(x))}))/range_round)*range_round
    ymin=floor(min(apply(a,2,function(x){min(na.omit(x))}))/range_round)*range_round
  } else {
    ymax=ceiling(max(na.omit(a))/range_round)*range_round
    ymin=floor(min(na.omit(a))/range_round)*range_round 
  }
  #plotting
  plot(0,0,xlim=c(0,length(this_span)),ylim=c(ymin,ymax),type="n",xlab='',ylab=ylab)
  
  col_count=0
  col_vec=NULL  
  for (j in legend_ind){
    color_ind=which(color_ref$variable==names(data)[j] )
    coll=as.character(color_ref$color[color_ind])   
    col_vec=c(col_vec,coll)
    lines(data[this_span,j],col=coll)
  }
  legend("topleft",legend=names(data)[legend_ind],lty=c(1,1),pt.cex=0,col=col_vec,bty="n",inset=inset)
  if (vert_bar>0) {
    par(xpd=FALSE)
    abline(v=vert_bar)
    par(xpd=TRUE)
  }
  
} 


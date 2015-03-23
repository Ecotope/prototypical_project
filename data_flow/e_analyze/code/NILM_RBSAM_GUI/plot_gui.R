



plot_gui=function(site,source,start,obs,vert_bar=0,enduses) {
  #find relevant data
  r_name=paste0("RBSAM_",source,"_",site)
  n_name=paste0(source,"_",site)
  r_data=GUI_list[[r_name]]
  n_data=GUI_list[[n_name]]  
  
  
  vert_bar=vert_bar*obs
  start=round(start*nrow(n_data))
  if (start==0) start=1
  n_finish=start+obs
  #set obs to max out at max obs
  if (n_finish>nrow(n_data)) n_finish=nrow(n_data)
  n_span=seq(start,n_finish)
  
  
  
  #establishing plotting parameters  
  par(mfrow=c(2,1),pty="m",mar=c(4, 15, 3,1),oma=c(5,0.1,1,1),xpd=TRUE) 
  
  if (source=="enetics") { ylab="Watts"} else {ylab="kWh"}
  #NILM plot
  nilm_ind=which(names(n_data) %in%  enduses)
  
  if (length(nilm_ind)>0) {
    try(sub_routine(ind=nilm_ind,data=n_data,this_span=n_span,ylab=ylab,
                    inset=c(-0.32,0),vert_bar=vert_bar,range_round=.1))
    
    title(paste0(CA(source)," Site ", site," Starting on: ",as.character(n_data$Date[1])))
    mtext("NILM")
  }
  
  #RBSAM plot
  rbsam_ind=which(names(r_data) %in% enduses)
  #   names(r_data)[rbsam_ind]
  if (length(rbsam_ind)>0) {
    
    try(sub_routine(ind=rbsam_ind,data=r_data,this_span=n_span,ylab=ylab,
                    inset=c(-0.32,0),vert_bar=vert_bar,range_round=.1))
    mtext("RBSAM")
  }
  
  
  if (source=="enetics") {
    if (site==14331) {title(xlab="15 Minute Intervals")} else {title(xlab="5 Minute Intervals")}
  } else {
    title(xlab="Days")  
  }
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



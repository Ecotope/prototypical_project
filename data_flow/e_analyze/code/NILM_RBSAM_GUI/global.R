library("reports")
rdas=list.files(pattern=".rda")

for (file in rdas) {
  load(file)
  
}

source("./plot_gui.R")
color_ref=read.csv("./color_ref.csv")

site_info=read.csv("./site_info.csv")


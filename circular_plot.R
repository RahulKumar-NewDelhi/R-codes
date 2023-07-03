library(circlize)
library(readxl)

input_data <- read_excel("/home/rahul/Downloads/Input_file_for_circular_genome_plot.xls")


data <- as.matrix(input_data)

chordDiagram(data)

chordDiagram(data, annotationTrack = "grid", preAllocateTracks = 1)

circos.trackPlotRegion(track.index = 2, panel.fun = function(x,y){
  xlim= get.cell.meta.data("xlim")
  ylim= get.cell.meta.data("ylim")
  sector.name= get.cell.meta.data("sector.index")
  
circos.text(mean(xlim), ylim[1]+ 2.5, sector.name, facing = "clockwise", niceFacing = TRUE, adj= c(0,0.5), cex= 0.6)

circos.axis(h= "top", labels.cex = 0.5, major.tick.percentage = 0.2, sector.index = sector.name, track.index = 2)
}, bg.border = NA)


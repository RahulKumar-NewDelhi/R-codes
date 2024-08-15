library(plasmapR)
library(ggplot2)
library(plotly)
library(stringr)
library(png)

files <- list.files(".", pattern = ".gbk", recursive = FALSE)
file_names <-  strsplit(files, "\\.gbk")
sample_names <- sub("-contig.*$", "", files)

process_and_plot_file <- function(file, name, filename) {
  map_name <- " "
  p <- file |> read_gb()|> plot_plasmid(map_name)
  p <- p + ggtitle(filename) + theme(plot.title = element_text(hjust = 0.5))
  p <- p + annotate("text", x = 0, y = 0, label = name, size = 4, hjust = 0.5, vjust = 0.2)
  png_filename <- paste0(filename, ".png")
  png(png_filename, width = 800, height = 600)
  print(p)
  dev.off()

}

for (i in seq_along(files)) {
  process_and_plot_file(files[i], sample_names[i], file_names[i])

}

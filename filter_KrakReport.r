library(tidyverse)
library(tidyr)
library(dplyr)
library(purrr)


kreport_files <- list.files(".", pattern = ".kreport*")
number_of_kreport_files <- length(kreport_files)
kreport_N_files <- gsub(pattern = "\\.kreport*$", "", kreport_files)
file_name <- paste0((kreport_N_files), ".filtered_kreport.tsv")


kreport_df <- function(files){
  k_files <- read_tsv(files, col_names = FALSE, comment="#")
  files <- gsub(pattern = "\\.kreport.tsv$", "", files)
  return(k_files)
}

required_kreport_files <- map(kreport_files, kreport_df)
required_kreport_files <- as.data.frame(do.call(rbind, required_kreport_files))
required_kreport_files <- required_kreport_files %>% filter(!(required_kreport_files$X4 == "U" | required_kreport_files$X4 == "-"), )

sort_species <- function(kreportfiles){
  sorted_species <- filter(kreportfiles)
  return(sorted_species)
}

species_selected <- sort_species(required_kreport_files)
species_selected <- species_selected[order(species_selected$X2, decreasing= TRUE), ]
top_species_selected <- head(species_selected, 100)
num_reads <- as.list(top_species_selected$X2)
lowest_value <- min(unlist(num_reads))

removed_species <- required_kreport_files %>% filter(required_kreport_files$X2 < lowest_value, )
top_n_selected_species <- anti_join(required_kreport_files, removed_species, by= "X2")

top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "D"), paste("  ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "P"), paste("    ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "C"), paste("      ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "O"), paste("        ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "F"), paste("          ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "G"), paste("            ", X6), X6))
top_n_selected_species <- top_n_selected_species %>% mutate(X6 = ifelse(str_detect(X4, "S"), paste("              ", X6), X6))

write_tsv(top_n_selected_species, file = file_name, col_names = FALSE)


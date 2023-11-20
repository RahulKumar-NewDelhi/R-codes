library(jsonlite)
library(officer)
library(dplyr)
library(tidyverse)
library(tinytex)
library(tidyr)
library(plyr)
library(dplyr)
library(data.table)
library(ggplot2)
library(stringr)
library(purrr)


logo <-  company_information$logo
title <- if(company_information$title != "") {company_information$title}  else{toupper(params$sample_name)}
date <- Sys.Date()
author <- company_information$authors
subtitle <- company_information$subtitle
email <- company_information$email
website <- company_information$website
address <- company_information$address

report <- fromJSON("report_folder/report.json")



body_add_par_n <- function(doc, n) {
    i <- 1
    while (i<=n) {
        doc <- body_add_par(doc, "")
        i <- i+1
    }
    
    doc
}

word_doc <- read_docx()

word_doc <- word_doc %>% body_add_img(logo, width = 1, height = 0.5, style = "Normal", pos = "after") %>% body_add_par_n(5) %>%
    body_add_par(title, style = "centered", pos = "after") %>% body_add_par(date, style = "centered", pos = "after") %>%
    body_add_par("") %>% body_add_par(author, style = "centered", pos = "after") %>% body_add_par("") %>% body_add_par_n(5) %>%
    body_add_par(subtitle, style = "centered", pos = "after") %>% body_add_par_n(25) %>% body_add_par(address, style = "centered", pos = "after") %>% 
    body_add_par(email, style = "centered", pos = "after") %>% body_add_par(website, style = "centered", pos = "after") %>% body_add_break(pos = "after") %>% 
    body_add_img(logo, width = 0.8, height = 0.3, style = "Normal", pos = "after") %>% body_add_par("Introduction", style = "heading 1") %>% 
    body_add_par("") %>% body_add_par(report$Introduction[1], style = "Normal") %>% body_add_par_n(1) %>%
    body_add_par("Data Analysis", style = "heading 1") %>% body_add_par(report$`Data Analysis`[1], style = "Normal") %>% body_add_par_n(1) %>% 
    body_add_par("Data Statistics", style = "heading 1") %>% body_add_par(report$`Data Statistics`[1], style = "Normal") %>% body_add_par_n(1) %>%
    body_add_gg(plot_read_statistics, width = 6, height = 5, res = 300, style = "Normal", scale = 1, pos = "after") %>%
    body_add_table(assembly_df, style = "Normal", pos = "after", header = TRUE, align_table = "center") %>%
    body_add_par("Gene Prediction", style = "heading 1") %>% body_add_par(report$`Gene Prediction`[1], style = "Normal")
    

print(word_doc, "officer_new.docx")
library(ggsankey)
library(ggplot2)
library(plotly)

platform <- sample(x=c("Nanopore", "Illumina"), size = 10, replace = TRUE)
tools <- sample(x=c("Bowtie2", "Hisat2"), size = 10, replace = TRUE)
workflows <- sample(x=c("exome Analysis","RNASeq Analysis"), size = 10, replace = TRUE)

df <- cbind(platform, tools, workflows)
data <- data.frame(df)

required <- data %>% make_long(platform, tools, workflows)

my_color <- 'd3.scaleOrdinal() .domain(["a", "b"]) .range(["#69b3a2", "steelblue"])'

plot_req <- ggplot(required, aes(x = x, next_x = next_x, node=node, next_node = next_node, fill = factor(node), label = node)) + geom_sankey() + 
    geom_sankey_label(size = 3.5, color = 1, fill = "white") + scale_fill_viridis_d() +  theme_sankey(base_size = 16) + theme(legend.position = "none") + 
    geom_sankey_text(aes(label = node), size = 3.5, vjust = -1.5, check_overlap = TRUE)
    
ggplotly(plot_req)

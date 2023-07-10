library(dplyr)
library(data.table)

args = commandArgs(trailingOnly=TRUE)
best_hits = args[1]
pfam_headers = args[2]
pfam_clans = args[3]

data_file1 <- read.csv(best_hits, header = FALSE, sep="\t")
data_file2 <- read.csv(pfam_headers, header= FALSE, sep= " ")
pfam_clans <- read.csv(pfam_clans, header= FALSE, sep= "\t")

data_file3 <- dplyr::select(data_file1, c(V2))
colnames(data_file3) <- c("V1")
head(data_file3)

data_file4 <- dplyr:: select(data_file2, c(V1))
data_file5 <- as.data.frame(gsub(">", "", data_file4$V1))
colnames(data_file5) <- c("V1")
# head(data_file5)

data_file6 <- dplyr:: select(data_file2, c(V3))
# head(data_file6)

new_data_file2 <- cbind(data_file5, data_file6)
head(new_data_file2)

# setDT(data_file3)
# setkey(setDT(new_data_file2), V1,V3)
# head(new_data_file2[data_file3])

new_df_PG1a_vs_PFAM_DB_headers <- merge(new_data_file2, data_file3, by="V1")
head(new_df_PG1a_vs_PFAM_DB_headers)
write.csv(new_df_PG1a_vs_PFAM_DB_headers,"/mnt/datalake/ngsa/analysis/rahul/file1_and_file2.tsv", row.names = FALSE)

library(plyr)
required_data <- merge(new_data_file2, data_file5, by="V1")
# head(required_data)


# head(pfam_clans)

library(stringr)
new_dataframe <- data.frame(required_data, do.call(rbind, strsplit(required_data$V3,";")))
# head(new_dataframe)
new_dataframe_without_decimal <- data.frame(new_dataframe, do.call(rbind, strsplit(new_dataframe$X1,"\\.")))
# head(new_dataframe_without_decimal)

pfam_column <- dplyr::select(new_dataframe_without_decimal, c(X1.1))
colnames(pfam_column) <- c("V1")
head(pfam_column)

library(plyr)
new <- merge(pfam_clans,pfam_column, by="V1")
write.csv(new,"/mnt/datalake/ngsa/analysis/rahul/after_matching_with_pfam.tsv", row.names= FALSE)

# new_1 <- merge(pfam_clans, pfam_column, by="V1")
# head(new_1)

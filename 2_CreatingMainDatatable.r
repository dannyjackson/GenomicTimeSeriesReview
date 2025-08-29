# R code used to combine datatables from different statistics into one file called alldata.csv
# The published dataset is a subset of columns in alldata.csv, containing only on the data that was relevant to the final publication
# All raw csvs are in the github repository

# Load libraries
library(dplyr)
library(tidyverse)

# Read in all data tables
df1 <- read.csv('DataTables/filtered/filtered_effectivepopulation.csv')
df2 <- read.csv('DataTables/filtered/filtered_nucleotidediversity.csv')
df3 <- read.csv('DataTables/filtered/filtered_inbreeding.csv')
df4 <- read.csv('DataTables/filtered/filtered_populationstructure.csv')
df5 <- read.csv('DataTables/filtered/filtered_geneflow.csv')
df6 <- read.csv('DataTables/filtered/filtered_selection.csv')
df7 <- read.csv('DataTables/filtered/filtered_drift.csv')
df8 <- read.csv('DataTables/filtered/filtered_fst.csv')
df9 <- read.csv('DataTables/filtered/filtered_tajima.csv')
df10 <- read.csv('DataTables/filtered/filtered_molecularclock.csv')
df11 <- read.csv('DataTables/filtered/filtered_parallel.csv')
df12 <- read.csv('DataTables/paperinfo.csv')

# standardize column names
names(df6)[names(df6) == "selection_measured_in_time_series_data"] <- "measured_in_time_series_data"
names(df1)[names(df1) == "measured_in_time.series_data"] <- "measured_in_time_series_data"
names(df3)[names(df3) == "measure_in_time_series_data"] <- "measured_in_time_series_data"
names(df9)[names(df9) == "measured_in_time_series"] <- "measured_in_time_series_data"
names(df3)[names(df3) == "doi"] <- "File.Name"
names(df10)[names(df10) == "measured_in_time_series"] <- "measured_in_time_series_data"


# Combine datatables
## combine 1 and 2
combined_df <- df1 %>%
  merge(df2, by = "File.Name", suffix = c("_ep", "_nd"))

combined_df_tmp <- setNames(combined_df,paste0(names(combined_df),ifelse(names(combined_df) %in% setdiff(names(df1),names(df2)),"_ep","")))

combined_df <- combined_df_tmp

combined_df_tmp <- setNames(combined_df,paste0(names(combined_df),ifelse(names(combined_df) %in% setdiff(names(df2),names(df1)),"_nd","")))

combined_df <- combined_df_tmp

names(combined_df)

## add in 3
combined_df_tmp <- combined_df %>%
  merge(df3, by = "File.Name", suffix = c("", "_ib"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df3),names(combined_df)),"_ib","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 4
combined_df_tmp <- combined_df %>%
  merge(df4, by = "File.Name", suffix = c("", "_ps"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df4),names(combined_df)),"_ps","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 5
combined_df_tmp <- combined_df %>%
  merge(df5, by = "File.Name", suffix = c("", "_gf"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df5),names(combined_df)),"_gf","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 6; selection
combined_df_tmp <- combined_df %>%
  merge(df6, by = "File.Name", suffix = c("", "_selection"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df6),names(combined_df)),"_selection","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 7; drift
combined_df_tmp <- combined_df %>%
  merge(df7, by = "File.Name", suffix = c("", "_drift"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df7),names(combined_df)),"_drift","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 8; fst
combined_df_tmp <- combined_df %>%
  merge(df8, by = "File.Name", suffix = c("", "_fst"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df8),names(combined_df)),"_fst","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 9; tajima
combined_df_tmp <- combined_df %>%
  merge(df9, by = "File.Name", suffix = c("", "_tajima"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df9),names(combined_df)),"_tajima","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 10; molecular clock
combined_df_tmp <- combined_df %>%
  merge(df10, by = "File.Name", suffix = c("", "_mc"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df10),names(combined_df)),"_mc","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 11; parallel
combined_df_tmp <- combined_df %>%
  merge(df11, by = "File.Name", suffix = c("", "_parallel"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df11),names(combined_df)),"_parallel","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

## add in 12; paperinfo
combined_df_tmp <- combined_df %>%
  merge(df12, by = "File.Name", suffix = c("", "_paperinfo"))

combined_df_tmp2 <- setNames(combined_df_tmp,paste0(names(combined_df_tmp),ifelse(names(combined_df_tmp) %in% setdiff(names(df12),names(combined_df)),"_paperinfo","")))

names(combined_df_tmp2)

combined_df <- combined_df_tmp2

measure_cols <- combined_df %>%
  select(starts_with("measured_in_time_series_data"))

# Filter rows where all values are either NA or "no"
filtered_df <- combined_df %>%
  filter(apply(measure_cols, 1, function(row) all(is.na(row) | row == "no")))

# Print the filtered result
print(filtered_df)

# remove irrelevant columns
to_remove <- c("X0_ep", "X.effective.population._ep", "X.nucleotide.diversity._nd", "include_ib", "X_ib", "X.1_ib", "X.gene.flow._gf", "X0_selection", "X.selection._selection", "X.balancing.selection._selection", "X.purifying.selection._selection", "X.positive.selection._selection", "X.selection.coefficient._selection", "X.gene.ontology._selection", "fitness._selection", "assigned_selection", "added_genes_to_list_selection", "X_selection", "X.drift._drift", "X_drift", "X.1_drift", "X.fst._fst", "X.Tajima._tajima", "X_tajima", "X.molecular.clock._mc", "X_mc", "X.1_mc", "X_paperinfo", "x_paperinfo", "include_1stround_paperinfo", "include_2ndround_paperinfo")
`%ni%` <- Negate(`%in%`)
combined_df_tmp <- subset(combined_df,select = names(combined_df) %ni% to_remove)

combined_df <- combined_df_tmp

# Write to file
write.csv(combined_df, "DataTables/alldata.csv")

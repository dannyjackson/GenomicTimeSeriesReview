# R code used to create files that match the metadata for each paper to extracted data in the population statistic files

# Load packages
library(dplyr)
library(ggplot2)

# Merge paper info from paperinfo.csv with data for nucleotide diversity

## First, read in each csv
df1 <- read.csv('DataTables/filtered/filtered_nucleotidediversity.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

## make sure that all values in df1 and df2 match by file name
unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)

unique(df$level_of_analysis)
unique(df$increased_decreased)

## Standardize terms
df$increased_decreased[df$increased_decreased=="decreased then increased"] <- "varies"
df$increased_decreased[df$increased_decreased=="decreased; no change"] <- "decreased"
df$increased_decreased[df$increased_decreased=="no change; non-significant decrease"] <- "no change"
df$increased_decreased[df$increased_decreased=="fluctuates"] <- "varies"

df$increased_decreased_simple = df$increased_decreased
df$increased_decreased_simple[df$increased_decreased_simple=="varies"] <- NA
df$increased_decreased_simple[df$increased_decreased_simple=="no change"] <- NA

## Remove NA values
df_filtered <- df %>%
  filter(!is.na(increased_decreased))

## Write to file
write.csv(df_filtered, "DataTables/popstats/df_nucleotidediversity.csv")


# Repeat for effective population size

df1 <- read.csv('DataTables/filtered/filtered_effectivepopulation.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time.series_data),]

df <- df[df$measured_in_time.series_data == "yes",]

nrow(df)

df[,c("hypothesized_driver_of_change", "Driver.of.change.std", "File.Name")]
unique(df$increase_decrease)


df$increase_decrease[df$increase_decrease=="decrease; increase in deep history followed by decrease, increase, decrease"] <- "decrease"
df$increase_decrease[df$increase_decrease=="stable,decrease"] <- "decrease"
df$increase_decrease[df$increase_decrease=="decrease; bottleneck followed by expansion"] <- "decrease"
df$increase_decrease[df$increase_decrease=="none"] <- "stable"
df$increase_decrease[df$increase_decrease=="increase; peakiness with covid outbreak trends"] <- "increase"
df$increase_decrease[df$increase_decrease=="test of method for inferring historical Ne"] <- NA
df$increase_decrease[df$increase_decrease=="decrease; potenial for slight expansion in Bay Area, compared 3 populations and models from historic and moden samples, varying patterns"] <- "decrease"
df$increase_decrease[df$increase_decrease=="increase; population bottleneck at onset of experiment followed by increase and then decrease"] <- "increase"
df$increase_decrease[df$increase_decrease=="increase; increase after infection then stabilize over 17 years"] <- "increase"
df$increase_decrease[df$increase_decrease=="both; change in strain proportion of population over time"] <- NA                           
df$increase_decrease[df$increase_decrease==""] <- NA
unique(df$increase_decrease)


df_filtered <- df %>%
  filter(!is.na(increase_decrease))


write.csv(df_filtered, "DataTables/popstats/df_effectivepopulation.csv")


# Repeat for population structure 

df1 <- read.csv('DataTables/filtered/filtered_populationstructure.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)

unique(df$increase_or_decrease)

df$increase_or_decrease[df$increase_or_decrease=="none overall, decrease in southern California"] <- "none"
df$increase_or_decrease[df$increase_or_decrease=="increased"] <- "increase"
df$increase_or_decrease[df$increase_or_decrease=="both"] <- "varies"

df_filtered <- df %>%
  filter(!is.na(increase_or_decrease))

unique(df$increase_or_decrease)

write.csv(df_filtered, "DataTables/popstats/df_populationstructure.csv")

# Repeat for gene flow 

df1 <- read.csv('DataTables/filtered/filtered_geneflow.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

# make sure that all values in df1 and df2 match by file name
unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

unique(df$measured_in_time_series_data)

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)

unique(df$increase_or_decrease)

df$increase_or_decrease[df$increase_or_decrease=="constant"] <- "no change"
df$increase_or_decrease[df$increase_or_decrease=="increase (in some populations)"] <- "increase"

df_filtered <- df %>%
  filter(!is.na(increase_or_decrease))

unique(df$increase_or_decrease)

write.csv(df_filtered, "DataTables/popstats/df_geneflow.csv")

# Repeat for inbreeding 

df1 <- read.csv('DataTables/filtered/filtered_inbreeding.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measure_in_time_series_data),]

df <- df[df$measure_in_time_series_data == "yes",]

nrow(df)

unique(df$increase_or_decrease)

df$increase_or_decrease[df$increase_or_decrease=="none; inbreeding appears to be roughly the same arcoss historical and modern population"] <- "no change"
df$increase_or_decrease[df$increase_or_decrease=="decrease; decrease in both inbreeding and runs of homozygosity "] <- "decrease"
df$increase_or_decrease[df$increase_or_decrease=="decrese"] <- "decrease"
df$increase_or_decrease[df$increase_or_decrease=="none; genome diversity and inbreeding maintained low levels"] <- "no change"
df$increase_or_decrease[df$increase_or_decrease=="increase; only validated by one method, other did not detect inbreeding trend"] <- "increase"
df$increase_or_decrease[df$increase_or_decrease=="increase; almost all measures of inbreeding (Froh and mean ROH) increased from 2000-2018"] <- "increase"
df$increase_or_decrease[df$increase_or_decrease=="increase; more inbreeding found"] <- "increase"

df[,c("hypothesized_driver_of_change", "Driver.of.change.std", "File.Name")]

df_filtered <- df %>%
  filter(!is.na(increase_or_decrease))

unique(df$increase_or_decrease)

write.csv(df_filtered, "DataTables/popstats/df_inbreeding.csv")

# Repeat for selection

df1 <- read.csv('DataTables/filtered/filtered_selection.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")


df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$selection_measured_in_time_series_data),]

df <- df[df$selection_measured_in_time_series_data == "yes",]

nrow(df)

write.csv(df, "DataTables/popstats/df_selection.csv")

# Repeat for parallel

df1 <- read.csv('DataTables/filtered/filtered_parallel.csv')
df2 <- read.csv('DataTables/paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)

write.csv(df, "DataTables/popstats/df_parallel.csv")
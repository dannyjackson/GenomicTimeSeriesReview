# R code used to make Figure 3 (and Figure S3) and to generate statistics

# Load libraries
library(dplyr)
library(ggplot2)
library(ggpubr)
library(ggthemr)
library(tidyverse)

# Load the data table
combined_df <- read.csv("DataTables/final_datatables/alldata.csv")

# Subset by Driver of Change category
experimental <- combined_df[combined_df$Driver.of.change.std_paperinfo == "experimental",]
experimental <- experimental %>% drop_na(File.Name)

anthropogenic <- combined_df[combined_df$Driver.of.change.std_paperinfo == "anthropogenic",]
anthropogenic <- anthropogenic %>% drop_na(File.Name)

natural <- combined_df[combined_df$Driver.of.change.std_paperinfo == "natural evolution",]
natural <- natural %>% drop_na(File.Name)

hostpathogen <- combined_df[combined_df$Driver.of.change.std_paperinfo == "host-pathogen",]
hostpathogen <- hostpathogen %>% drop_na(File.Name)

simulation <- combined_df[combined_df$Driver.of.change.std_paperinfo == "simulation",]
simulation <- simulation %>% drop_na(File.Name)

# Check counts for each category
nrow(experimental)
nrow(anthropogenic)
nrow(natural)
nrow(hostpathogen)
nrow(simulation)

# Clean inconsistent labels for anthropogenic category
unique(anthropogenic$increase_decrease_ep)
anthropogenic$increase_decrease_ep[anthropogenic$increase_decrease_ep=="decrease; increase in deep history followed by decrease, increase, decrease"] <- "decrease"
anthropogenic$increase_decrease_ep[anthropogenic$increase_decrease_ep=="decrease; potenial for slight expansion in Bay Area, compared 3 populations and models from historic and moden samples, varying patterns"] <- "decrease"
anthropogenic$increase_decrease_ep[anthropogenic$increase_decrease_ep=="none"] <- "no change"

unique(anthropogenic$increase_decrease_nd)
anthropogenic$increase_decrease_nd[anthropogenic$increase_decrease_nd=="decreased then increased"] <- "no change"
anthropogenic$increase_decrease_nd[anthropogenic$increase_decrease_nd=="decreased; no change"] <- "no change"
anthropogenic$increase_decrease_nd[anthropogenic$increase_decrease_nd=="no change; non-significant decrease"] <- "no change"

anthropogenic$increase_decrease_nd[anthropogenic$increase_decrease_nd=="decreased"] <- "decrease"
anthropogenic$increase_decrease_nd[anthropogenic$increase_decrease_nd=="increased"] <- "increase"

unique(anthropogenic$increase_decrease_ib)
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="none; inbreeding appears to be roughly the same arcoss historical and modern population"] <- "no change"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="decrease; decrease in both inbreeding and runs of homozygosity "] <- "decrease"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="none; genome diversity and inbreeding maintained low levels"] <- "no change"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="decrese"] <- "decrease"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="none; genome diversity and inbreeding maintained low levels"] <- "no change"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="increase; only validated by one method, other did not detect inbreeding trend"] <- "increase"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="increase; almost all measures of inbreeding (Froh and mean ROH) increased from 2000-2018"] <- "increase"
anthropogenic$increase_decrease_ib[anthropogenic$increase_decrease_ib=="increase; more inbreeding found"] <- "increase"

unique(anthropogenic$increase_decrease_ps)
anthropogenic$increase_decrease_ps
anthropogenic$doi 
anthropogenic$increase_decrease_ps[anthropogenic$increase_decrease_ps=="both"] <- "no change"

unique(anthropogenic$increase_decrease_gf)
anthropogenic$increase_decrease_gf


# Join with manually curated file with refined anthropogenic drivers
## We revisited each paper during the writing process and some had improperly assigned categories, so this file reassigns them
reassign_df <- read.csv("anthro_short_edited.csv")

# Merge to assign subcategories (e.g., conservation, domestication)
anthropogenic_tmp <- anthropogenic %>%
  left_join(reassign_df, by = "File.Name")
names(anthropogenic_tmp)
anthropogenic$Driver.of.change.sub.anthro <- anthropogenic_tmp$revised_big
# anthropogenic$Driver.of.change.sub.anthro <- anthropogenic_tmp$revise.y
anthropogenic$Driver.of.change.sub.anthro

# Pull specific stats for particular studies or subcategories
## Used this code to check stats for each paper during the writing process

# Example: check metrics for a particular paper
anthropogenic %>%
  filter(File.Name == "10.1186_s12862-022-02083-w.pdf") %>%
  select("increase_decrease_ep", "increase_decrease_nd", "increase_decrease_ib", "increase_decrease_gf", "increase_decrease_ps")

# Example: filter by specific anthropogenic driver like "climate change"

anthropogenic %>%
  filter(Driver.of.change.sub.anthro == "climate change") %>%
  select("File.Name", "first_author_paperinfo", "increase_decrease_ep", "increase_decrease_nd", "increase_decrease_ib", "increase_decrease_gf", "increase_decrease_ps")

# Filter datasets for plotting each genomic metric

colnames(anthropogenic)
anthropogenic %>%
  filter(Driver.of.change.sub.anthro == "hunting, fishing, and trading") %>%
  select("File.Name", "first_author_paperinfo", "increase_decrease_ep", "increase_decrease_nd", "increase_decrease_ib", "increase_decrease_gf", "increase_decrease_ps")


anthropogenic %>%
  filter(Driver.of.change.sub.anthro == "domestication and agriculture") %>%
  select("File.Name", "first_author_paperinfo", "increase_decrease_ep", "increase_decrease_nd", "increase_decrease_ib", "increase_decrease_gf", "increase_decrease_ps")


anthropogenic %>%
  filter(Driver.of.change.sub.anthro == "broad") %>%
  select("File.Name", "first_author_paperinfo", "increase_decrease_ep", "increase_decrease_nd", "increase_decrease_ib", "increase_decrease_gf", "increase_decrease_ps")


anthropogenic[,c("Taxon_paperinfo", "File.Name")]
names(anthropogenic)
# anthropogenic$increase_decrease_ps
# anthropogenic$increase_decrease_gf[anthropogenic$increase_decrease_gf=="no change; non-significant decrease"] <- "no change"

# plot all anthropogenic data together


# plot all anthropogenic data together
anthro_effectivepop <- anthropogenic %>%
  filter(!is.na(increase_decrease_ep))

anthro_nucleotide <- anthropogenic %>%
  filter(!is.na(increase_decrease_nd))

anthro_inbreeding <- anthropogenic %>%
  filter(!is.na(increase_decrease_ib))

anthro_popstructure <- anthropogenic %>%
  filter(!is.na(increase_decrease_ps))

anthro_geneflow <- anthropogenic %>%
  filter(!is.na(increase_decrease_gf))


# Define all desired categories
desired_categories <- c("human activities", "conservation", "domestication and agriculture", "human evolution")

anthro_effectivepop$Driver.of.change.sub.anthro <- factor(anthro_effectivepop$Driver.of.change.sub.anthro, levels = desired_categories)

# effective population

data_summary <- as.data.frame(table(anthro_effectivepop$Driver.of.change.sub.anthro, 
                                    anthro_effectivepop$increase_decrease_ep))
colnames(data_summary) <- c("Driver.of.change.sub.anthro", "increase_decrease_ep", "Count")

# Define color mapping
colors <- c("increase" = "blue", "decrease" = "red", "no change" = "lightgray")

# Create the horizontal stacked bar plot
anthro_ep <- ggplot(data_summary, aes(x = Count, 
                         y = Driver.of.change.sub.anthro, 
                         fill = increase_decrease_ep)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = colors) +
  labs(x = "Count", y = "Driver of Change", fill = "Change Type",
       title = "Horizontal Stacked Bar Plot of Change Types") +
  theme_minimal()



# nucleotide diversity
anthro_nucleotide$Driver.of.change.sub.anthro
anthro_nucleotide$increase_decrease_ep

desired_categories <- c("human activities", "conservation", "domestication and agriculture", "human evolution")

anthro_nucleotide$Driver.of.change.sub.anthro <- factor(anthro_nucleotide$Driver.of.change.sub.anthro, levels = desired_categories)

data_summary <- as.data.frame(table(anthro_nucleotide$Driver.of.change.sub.anthro, 
                                    anthro_nucleotide$increase_decrease_nd))
colnames(data_summary) <- c("Driver.of.change.sub.anthro", "increase_decrease_nd", "Count")

# Define color mapping
colors <- c("increase" = "blue", "decrease" = "red", "no change" = "lightgray")

# Create the horizontal stacked bar plot
anthro_nd <- ggplot(data_summary, aes(x = Count, 
                         y = Driver.of.change.sub.anthro, 
                         fill = increase_decrease_nd)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = colors) +
  labs(x = "Count", y = "Driver of Change", fill = "Change Type",
       title = "Horizontal Stacked Bar Plot of Change Types") +
  theme_minimal()


# inbreeding
anthro_inbreeding$Driver.of.change.sub.anthro
anthro_inbreeding$increase_decrease_ib

desired_categories <- c("human activities", "conservation", "domestication and agriculture", "human evolution")

anthro_inbreeding$Driver.of.change.sub.anthro <- factor(anthro_inbreeding$Driver.of.change.sub.anthro, levels = desired_categories)

data_summary <- as.data.frame(table(anthro_inbreeding$Driver.of.change.sub.anthro, 
                                    anthro_inbreeding$increase_decrease_ib))
colnames(data_summary) <- c("Driver.of.change.sub.anthro", "increase_decrease_ib", "Count")

# Define color mapping
colors <- c("increase" = "blue", "decrease" = "red", "no change" = "lightgray")

# Create the horizontal stacked bar plot
anthro_ib <- ggplot(data_summary, aes(x = Count, 
                         y = Driver.of.change.sub.anthro, 
                         fill = increase_decrease_ib)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = colors) +
  labs(x = "Count", y = "Driver of Change", fill = "Change Type",
       title = "Horizontal Stacked Bar Plot of Change Types") +
  theme_minimal()




# population structure
anthro_popstructure$Driver.of.change.sub.anthro
anthro_popstructure$increase_decrease_ps

desired_categories <- c("human activities", "conservation", "domestication and agriculture", "human evolution")

anthro_popstructure$Driver.of.change.sub.anthro <- factor(anthro_popstructure$Driver.of.change.sub.anthro, levels = desired_categories)

data_summary <- as.data.frame(table(anthro_popstructure$Driver.of.change.sub.anthro, 
                                    anthro_popstructure$increase_decrease_ps))
colnames(data_summary) <- c("Driver.of.change.sub.anthro", "increase_decrease_ps", "Count")

# Define color mapping
colors <- c("increase" = "blue", "decrease" = "red", "no change" = "lightgray")

# Create the horizontal stacked bar plot
anthro_ps <- ggplot(data_summary, aes(x = Count, 
                         y = Driver.of.change.sub.anthro, 
                         fill = increase_decrease_ps)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = colors) +
  labs(x = "Count", y = "Driver of Change", fill = "Change Type",
       title = "Horizontal Stacked Bar Plot of Change Types") +
  theme_minimal()



# gene flow

anthro_geneflow$Driver.of.change.sub.anthro
anthro_geneflow$increase_decrease_gf

desired_categories <- c("human activities", "conservation", "domestication and agriculture", "human evolution")

anthro_geneflow$Driver.of.change.sub.anthro <- factor(anthro_geneflow$Driver.of.change.sub.anthro, levels = desired_categories)

data_summary <- as.data.frame(table(anthro_geneflow$Driver.of.change.sub.anthro, 
                                    anthro_geneflow$increase_decrease_gf))
colnames(data_summary) <- c("Driver.of.change.sub.anthro", "increase_decrease_gf", "Count")

# Define color mapping
colors <- c("increase" = "blue", "decrease" = "red", "no change" = "lightgray")

# Create the horizontal stacked bar plot
anthro_gf <- ggplot(data_summary, aes(x = Count, 
                         y = Driver.of.change.sub.anthro, 
                         fill = increase_decrease_gf)) +
  geom_bar(stat = "identity", position = "stack") +
  scale_fill_manual(values = colors) +
  labs(x = "Count", y = "Driver of Change", fill = "Change Type",
       title = "Horizontal Stacked Bar Plot of Change Types") +
  theme_minimal()

# Export each plot as PDF

pdf(file = "anthro_ep.pdf",   
    width = 8,
    height = 4) 
anthro_ep
dev.off()

pdf(file = "anthro_nd.pdf",   
    width = 8,
    height = 4) 
anthro_nd
dev.off()

pdf(file = "anthro_ib.pdf",   
    width = 8,
    height = 4) 
anthro_ib
dev.off()

pdf(file = "anthro_ps.pdf",   
    width = 8,
    height = 4) 
anthro_ps
dev.off()

pdf(file = "anthro_gf.pdf",   
    width = 8,
    height = 4) 
anthro_gf
dev.off()

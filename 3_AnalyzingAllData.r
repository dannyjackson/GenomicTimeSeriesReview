# R code used to generate Figure 1

# Load libraries
library(dplyr)
library(ggplot2)
library(ggpubr)
library(ggthemr) # devtools::install_github('Mikata-Project/ggthemr') 
library(tidyverse)
library(corrplot)
library(gridExtra)
library(patchwork)

# read in the dataframe of all papers with associated information
df <- read.csv("DataTables/final_datatables/alldata.csv")

# assess some general stats of the data
nrow(df)
names(df)
mean(df$year_paperinfo)
min(df$year_paperinfo)
max(df$year_paperinfo)

df %>%
  count(Study.system_paperinfo)

# identify any empty fields in the df
df[is.na(df$Study.system_paperinfo),]
df[is.na(df$Data.type_paperinfo),]
df[is.na(df$Experimental.design_paperinfo),]

# clean up a few unstandardized or empty fields in the dataframe
df$Study.system_paperinfo[df$File.Name=="10.1093_molbev_msz183.pdf"] <- "simulation"
df$Study.system_paperinfo[df$Study.system_paperinfo=="yeast"] <- "fungus"
df$Study.system_paperinfo[df$Study.system_paperinfo=="bacteria/virus"] <- "microbes"
df$Study.system_paperinfo[df$Study.system_paperinfo=="bacteria"] <- "microbes"
df$Data.type_paperinfo[df$File.Name=="10.1093_molbev_msu192.pdf"] <- "simulation"
df$Data.type_paperinfo[df$File.Name=="10.1093_molbev_msz183.pdf"] <- "simulation"
df$Driver.of.change.std_paperinfo[df$File.Name=="10.1534_g3.115.023200.pdf"] <- "host-pathogen"
df$Experimental.design_paperinfo[df$File.Name=="10.1093_molbev_msz183.pdf"] <- "simulation"
df$Experimental.design_paperinfo[df$File.Name=="10.1093_molbev_msu192.pdf"] <- "simulation"
df[df$File.Name=="10.1126_sciadv.aax0530.pdf", "Study.system_paperinfo"]  <- "host-pathogen"
df$Experimental.design_paperinfo[df$File.Name=="10.1111_mec.12260.pdf"] <- "repeated"
df$Experimental.design_paperinfo[df$File.Name=="10.3390_vaccines11101537.pdf"] <- "historical"

# subset the dataframe into core themes (experimental, anthropogenic, natural evolution, host-pathogen, and simulation)
experimental <- df[df$Driver.of.change.std_paperinfo == "experimental",]
experimental <- experimental %>% drop_na(File.Name)

anthropogenic <- df[df$Driver.of.change.std_paperinfo == "anthropogenic",]
anthropogenic <- anthropogenic %>% drop_na(File.Name)

natural <- df[df$Driver.of.change.std_paperinfo == "natural evolution",]
natural <- natural %>% drop_na(File.Name)

hostpathogen <- df[df$Driver.of.change.std_paperinfo == "host-pathogen",]
hostpathogen <- hostpathogen %>% drop_na(File.Name)

simulation <- df[df$Driver.of.change.std_paperinfo == "simulation",]
simulation <- simulation %>% drop_na(File.Name)

# create a plot of paper counts by year across categories 

# Define a consistent scale for point sizes across plots
common_size_limits <- c(1,15)

df[df["Experimental.design_paperinfo"] == "natural evol", c("Experimental.design_paperinfo","File.Name")]

df[df["Experimental.design_paperinfo"] == "simulation", c("Experimental.design_paperinfo","year_paperinfo")]

# experimental design by year
plot1 <- ggplot(df, aes(x = year_paperinfo, y = Experimental.design_paperinfo)) +
  geom_count(aes(size = ..n..)) +
  scale_size_continuous(limits = common_size_limits,  range = c(1, 7)) +
  labs(y = "Experimental Design") +
  theme_minimal() +  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

# data type by year
plot2 <-  ggplot(df, aes(x = year_paperinfo, y = Data.type_paperinfo)) +
  geom_count(aes(size = ..n..)) +
  scale_size_continuous(limits = common_size_limits, range = c(1, 7)) +
  labs(y = "Data Type") + 
  theme_minimal() +  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

# Driver of change by year
plot3 <- ggplot(df, aes(x = year_paperinfo, y = Driver.of.change.std_paperinfo)) +
    geom_count(aes(size = ..n..)) +
  scale_size_continuous(limits = common_size_limits,  range = c(1, 7)) +
  labs(y = "Driver of change") +
  theme_minimal() +  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

# Study system by year
plot4 <- ggplot(df, aes(x = year_paperinfo, y = Study.system_paperinfo)) +
    geom_count(aes(size = ..n..)) +
  scale_size_continuous(limits = common_size_limits,  range = c(1, 7)) +
  labs(x = "Year",
       y = "Study system") +
  theme_minimal()
# Arrange the plots vertically
# grid.arrange(plot1, plot2, plot3, plot4, ncol = 1)

pdf(file = "papercounts_year.revised.pdf",   
    width = 8,
    height = 12) 
plot1 / plot2 / plot3 / plot4
dev.off()


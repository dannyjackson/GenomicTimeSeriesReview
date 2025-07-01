# R code used to consolidate terms from screened papers in the file filtered_screened_papers.csv
# All raw csvs are in the github repository

# Load the dplyr package for data manipulation
library(dplyr)


df <- read.csv('DataTables/filtered/filtered_screened_papers.csv')

names(df)[names(df) == "pdf"] <- "File.Name"

# view unique codes used across Study.system
unique(df$Study.system)


# consolidate terms 
df$Study.system[df$Study.system=="invert"] <- "invertebrate"
df$Study.system[df$Study.system=="invert "] <- "invertebrate"
df$Study.system[df$Study.system=="vert"] <- "vertebrate"
df$Study.system[df$Study.system=="incert"] <- "invertebrate"
df$Study.system[df$Study.system=="microbe"] <- "microbes"
df$Study.system[df$Study.system=="microbe "] <- "microbes"

# repeat for Driver of change
unique(df$Driver.of.change)
df$Driver.of.change[df$Driver.of.change=="Experimental evolution"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="antrop (land use change)"] <- "land use; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="natural evol"] <- "natural evolution"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (longevity)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="exp evol"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="host-parasite"] <- "host-pathogen"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (salinity)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="antro (climate change)"] <- "climate change; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="introduction to europe"] <- "revisit"
df$Driver.of.change[df$Driver.of.change=="antrop (climate change)"] <- "climate change; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (sexual selection)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (hypoxia)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (temperature)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="domestication"] <- "domestication; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="natural evolution; anthropogenic"] <- "revisit"
df$Driver.of.change[df$Driver.of.change=="natural evol; anthropogenic"] <- "revisit"
df$Driver.of.change[df$Driver.of.change=="Experimental evolution (chem stressor)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="pesticide"] <- "pesticide; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="Exerimental evolution (temperature)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="NA"] <- "revisit"
df$Driver.of.change[df$Driver.of.change=="Exerimental evolution (starvation)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="Experimental evolution (bottleneck)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="antrop (domestication)"] <- "domestication; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (UV)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="Experimental Evolution (drought)"] <- "experimental"
df$Driver.of.change[df$Driver.of.change=="pollution"] <- "pollution; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="Envirionmental change"] <- "revisit"
df$Driver.of.change[df$Driver.of.change=="anthrop (overharvest)"] <- "overharvest; anthropogenic"
df$Driver.of.change[df$Driver.of.change=="antro (antimalaria drug use)"] <- "drug resistance; anthropogenic"

# further consolidate Driver of change into a new category, Driver.of.change.std
df$Driver.of.change.std = df$Driver.of.change
unique(df$Driver.of.change.std)

df$Driver.of.change.std[df$Driver.of.change.std=="climate change; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="pesticide; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="pollution; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="overharvest; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="drug resistance; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="land use; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="host-pathogen; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="domestication; anthropogenic"] <- "anthropogenic"
df$Driver.of.change.std[df$Driver.of.change.std=="Environmental change"] <- "revisit"
df$Driver.of.change.std[df$Driver.of.change.std=="drought"] <- "revisit"



                     
# repeat for Data.type
unique(df$Data.type)

df$Data.type[df$Data.type=="reduced rep"] <- "reduced representation"
df$Data.type[df$Data.type=="Disagreement"] <- "revisit"
df$Data.type[df$Data.type=="reduced representation   "] <- "reduced representation"
df$Data.type[df$Data.type=="pooled WGS"] <- "poolseq"
df$Data.type[df$Data.type=="Pooled WGS"] <- "poolseq"
df$Data.type[df$Data.type=="WGS  "] <- "WGS"
df$Data.type[df$Data.type=="WGS and reduced rep"] <- "WGS"
df$Data.type[df$Data.type=="reduced representation (genome size)"] <- "revisit"


# repeat for Experimental.design

unique(df$Experimental.design)

df$Experimental.design[df$Experimental.design=="Experimental evolution"] <- "experimental"
df$Experimental.design[df$Experimental.design=="Repeated samples"] <- "repeated"
df$Experimental.design[df$Experimental.design=="Experimental evol"] <- "experimental"
df$Experimental.design[df$Experimental.design=="repeated sampleing"] <- "repeated"
df$Experimental.design[df$Experimental.design=="historical samples"] <- "historical"
df$Experimental.design[df$Experimental.design=="Repeated sampling "] <- "repeated"
df$Experimental.design[df$Experimental.design=="xxexperimental evolxx"] <- "experimental"
df$Experimental.design[df$Experimental.design=="Experimental Evolution"] <- "experimental"
df$Experimental.design[df$Experimental.design=="repeated samples"] <- "repeated"
df$Experimental.design[df$Experimental.design=="Experimental Evolution "] <- "experimental"
df$Experimental.design[df$Experimental.design=="experimental evol"] <- "experimental"
df$Experimental.design[df$Experimental.design=="Disagreement"] <- "revisit"

# check all output for errors
unique(df$Study.system)
unique(df$Driver.of.change.std)
unique(df$Data.type)
unique(df$Experimental.design)


write.csv(df, "DataTables/paperinfo.csv")


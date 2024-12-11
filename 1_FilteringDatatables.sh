# bash code used to filter out excluded papers and R code to standardize codes across datatables

cd /Users/danjack/Library/CloudStorage/Box-Box/McNew\ Lab/collaboration/AmNat_PaperScreening/SearchTermDatafiles

cp -r /Users/danjack/Library/CloudStorage/Box-Box/McNew\ Lab/collaboration/AmNat_PaperScreening .
# First, make directories to keep files organized
mkdir filtered popstats originals notes figuredrafts
mv *csv originals
mv *docx note

# second, make copies of all files that are filtered for papers that we've decided to remove

# screened papers 

# i removed the following duplicates from the original screened.csv file. I removed the may entry rather than the august entry.
# 10.1099_mgen.0.001170.pdf
# 10.1186_s13059-018-1503-4.pdf


cp originals/screened_papers.csv filtered/filtered_screened_papers.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$4 != env_var { print $0 }' filtered/filtered_screened_papers.csv > filtered/filtered_screened_papers_temp.csv

mv filtered/filtered_screened_papers_temp.csv filtered/filtered_screened_papers.csv

done < files_to_remove.txt

# nucleotide diversity
cp originals/nucleotide\ diversity.csv filtered/filtered_nucleotidediversity.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$1 != env_var { print $0 }' filtered/filtered_nucleotidediversity.csv > filtered/filtered_nucleotidediversity_temp.csv

mv filtered/filtered_nucleotidediversity_temp.csv filtered/filtered_nucleotidediversity.csv

done < files_to_remove.txt

# effective population size
cp originals/effective\ population.csv filtered/filtered_effectivepopulation.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_effectivepopulation.csv > filtered/filtered_effectivepopulation_temp.csv

mv filtered/filtered_effectivepopulation_temp.csv filtered/filtered_effectivepopulation.csv

done < files_to_remove.txt

# population structure
cp originals/population\ structure_okayplease.csv filtered/filtered_populationstructure.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_populationstructure.csv > filtered/filtered_populationstructure_temp.csv

mv filtered/filtered_populationstructure_temp.csv filtered/filtered_populationstructure.csv

done < files_to_remove.txt


# gene flow 
cp originals/gene\ flow.csv filtered/filtered_geneflow.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$1 != env_var { print $0 }' filtered/filtered_geneflow.csv > filtered/filtered_geneflow_temp.csv

mv filtered/filtered_geneflow_temp.csv filtered/filtered_geneflow.csv

done < files_to_remove.txt

# inbreeding

cp originals/inbreeding.csv filtered/filtered_inbreeding.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$1 != env_var { print $0 }' filtered/filtered_inbreeding.csv > filtered/filtered_inbreeding_temp.csv

mv filtered/filtered_inbreeding_temp.csv filtered/filtered_inbreeding.csv

done < files_to_remove.txt

# selection

cp originals/selection_danny.csv filtered/filtered_selection.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_selection.csv > filtered/filtered_selection_temp.csv

mv filtered/filtered_selection_temp.csv filtered/filtered_selection.csv

done < files_to_remove.txt


# parallel

cp originals/parallel.csv filtered/filtered_parallel.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_parallel.csv > filtered/filtered_parallel_temp.csv

mv filtered/filtered_parallel_temp.csv filtered/filtered_parallel.csv

done < files_to_remove.txt

# drift 
cp originals/drift.csv filtered/filtered_drift.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_drift.csv > filtered/filtered_drift_temp.csv

mv filtered/filtered_drift_temp.csv filtered/filtered_drift.csv

done < files_to_remove.txt

# fst
cp originals/fst.csv filtered/filtered_fst.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_fst.csv > filtered/filtered_fst_temp.csv

mv filtered/filtered_fst_temp.csv filtered/filtered_fst.csv

done < files_to_remove.txt

# tajima
cp originals/tajima.csv filtered/filtered_tajima.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_tajima.csv > filtered/filtered_tajima_temp.csv

mv filtered/filtered_tajima_temp.csv filtered/filtered_tajima.csv

done < files_to_remove.txt

# molecularclock
cp originals/molecular\ clock.csv filtered/filtered_molecularclock.csv

while read -r term;
do

awk -v env_var="$term" -F "," '$2 != env_var { print $0 }' filtered/filtered_molecularclock.csv > filtered/filtered_molecularclock_temp.csv

mv filtered/filtered_molecularclock_temp.csv filtered/filtered_molecularclock.csv

done < files_to_remove.txt

# third, create a paper info document that has standard terms for different core pieces of data that we're interested in

# combine screened and effective pop and use effective pop to filter out excluded ppers in the screened document

R 

library(dplyr)


df <- read.csv('filtered/filtered_screened_papers.csv')

names(df)[names(df) == "pdf"] <- "File.Name"

unique(df$Study.system)

 [1] "invert"         "vertebrate"     "incert"         "plant"         
 [5] "virus"          "vert"           "microbe"        "bacteria"      
 [9] "microbes"       "invertebrate"   "microbe "       "bacteria/virus"
[13] "simulation"     "yeast"          NA               "invert " 


df$Study.system[df$Study.system=="invert"] <- "invertebrate"
df$Study.system[df$Study.system=="invert "] <- "invertebrate"
df$Study.system[df$Study.system=="vert"] <- "vertebrate"
df$Study.system[df$Study.system=="incert"] <- "invertebrate"
df$Study.system[df$Study.system=="microbe"] <- "microbes"
df$Study.system[df$Study.system=="microbe "] <- "microbes"

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



df$Driver.of.change.std = df$Driver.of.change
unique(df$Driver.of.change.std)
 [1] "experimental"                   "land use; anthropogenic"       
 [3] "natural evolution"              "host-pathogen"                 
 [5] "anthropogenic"                  "host-pathogen; anthropogenic"  
 [7] "climate change; anthropogenic"  "revisit"                       
 [9] "simulation"                     "domestication; anthropogenic"  
[11] "pesticide; anthropogenic"       NA                              
[13] "pollution; anthropogenic"       "Environmental change"          
[15] "overharvest; anthropogenic"     "drought"                       
[17] "drug resistance; anthropogenic"

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



                     
 [5] "metagenomics"                        
 [6] "reduced representation   "           
 [7] "reduced representation"              
 [8] "simulation"                          
 [9] "poolseq"                             
[10] "Pooled WGS"                          
[11] NA                                    
[12] "WGS  "                               
[13] "reduced representation (genome size)"
[14] "WGS and reduced rep" 

df$Data.type[df$Data.type=="reduced rep"] <- "reduced representation"
df$Data.type[df$Data.type=="Disagreement"] <- "revisit"
df$Data.type[df$Data.type=="reduced representation   "] <- "reduced representation"
df$Data.type[df$Data.type=="pooled WGS"] <- "poolseq"
df$Data.type[df$Data.type=="Pooled WGS"] <- "poolseq"
df$Data.type[df$Data.type=="WGS  "] <- "WGS"
df$Data.type[df$Data.type=="WGS and reduced rep"] <- "WGS"
df$Data.type[df$Data.type=="reduced representation (genome size)"] <- "revisit"



unique(df$Experimental.design)
 [1] "Experimental evolution"  "historical samples"     
 [3] "Experimental Evolution " "Repeated sampling "     
 [5] "historical"              "experimental evol"      
 [7] "repeated"                "experimental"           
 [9] "Repeated samples"        "Experimental Evolution" 
[11] "simulation"              "Disagreement"           
[13] NA                        "repeated samples"       
[15] "Experimental evol"       "natural evol"           
[17] "repeated sampleing" 

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

unique(df$Study.system)
unique(df$Driver.of.change.std)
unique(df$Data.type)
unique(df$Experimental.design)


# do not overwrite! i save the above as paperinfo.csv but then went in by hand and recoded the "revisit" values
# write.csv(df, "paperinfo.csv")

df <- read.csv('paperinfo.csv')

# fourth, complete the following in R to create files that match the paper meta-info to each pdf in the pop stat files

R 

# nucleotide diversity

library(dplyr)
library(ggplot2)


df1 <- read.csv('filtered/filtered_nucleotidediversity.csv')
df2 <- read.csv('paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0 
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)
26

unique(df$level_of_analysis)
unique(df$increased_decreased)

df$increased_decreased[df$increased_decreased=="decreased then increased"] <- "varies"
df$increased_decreased[df$increased_decreased=="decreased; no change"] <- "decreased"
df$increased_decreased[df$increased_decreased=="no change; non-significant decrease"] <- "no change"
df$increased_decreased[df$increased_decreased=="fluctuates"] <- "varies"

df$increased_decreased_simple = df$increased_decreased
df$increased_decreased_simple[df$increased_decreased_simple=="varies"] <- NA
df$increased_decreased_simple[df$increased_decreased_simple=="no change"] <- NA

df_filtered <- df %>%
  filter(!is.na(increased_decreased))

write.csv(df_filtered, "popstats/df_nucleotidediversity.csv")





# effective population size

df1 <- read.csv('filtered/filtered_effectivepopulation.csv')
df2 <- read.csv('paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time.series_data),]

df <- df[df$measured_in_time.series_data == "yes",]

nrow(df)
# 44

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


write.csv(df_filtered, "popstats/df_effectivepopulation.csv")


# population structure 


df1 <- read.csv('filtered/filtered_populationstructure.csv')
df2 <- read.csv('paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")

unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)
24



unique(df$increase_or_decrease)

[1] "none"                                         
[2] "increase"                                     
[3] "none overall, decrease in southern California"
[4] "decrease"                                     
[5] NA                                             
[6] "increased"                                    
[7] "both"  

df$increase_or_decrease[df$increase_or_decrease=="none overall, decrease in southern California"] <- "none"
df$increase_or_decrease[df$increase_or_decrease=="increased"] <- "increase"
df$increase_or_decrease[df$increase_or_decrease=="both"] <- "varies"

df_filtered <- df %>%
  filter(!is.na(increase_or_decrease))

unique(df$increase_or_decrease)

write.csv(df_filtered, "popstats/df_populationstructure.csv")



# gene flow 

df1 <- read.csv('filtered/filtered_geneflow.csv')
df2 <- read.csv('paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0 
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0

df <- merge(df1, df2, by = "File.Name")

unique(df$measured_in_time_series_data)

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)
# 27


unique(df$increase_or_decrease)

df$increase_or_decrease[df$increase_or_decrease=="constant"] <- "no change"
df$increase_or_decrease[df$increase_or_decrease=="increase (in some populations)"] <- "increase"

df_filtered <- df %>%
  filter(!is.na(increase_or_decrease))

unique(df$increase_or_decrease)

write.csv(df_filtered, "popstats/df_geneflow.csv")





# inbreeding 

df1 <- read.csv('filtered/filtered_inbreeding.csv')
df2 <- read.csv('paperinfo.csv')

names(df1)[names(df1) == "doi"] <- "File.Name"

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0 
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0

df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measure_in_time_series_data),]

df <- df[df$measure_in_time_series_data == "yes",]

nrow(df)
# 11



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

write.csv(df_filtered, "popstats/df_inbreeding.csv")



# selection

df1 <- read.csv('filtered/filtered_selection.csv')
df2 <- read.csv('paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0

unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0


df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$selection_measured_in_time_series_data),]

df <- df[df$selection_measured_in_time_series_data == "yes",]

nrow(df)
98

write.csv(df, "popstats/df_selection.csv")



# parallel

df1 <- read.csv('filtered/filtered_parallel.csv')
df2 <- read.csv('paperinfo.csv')

unmatched_df1 <- anti_join(df1, df2, by = "File.Name")
# 0
unmatched_df2 <- anti_join(df2, df1, by = "File.Name")
# 0



df <- merge(df1, df2, by = "File.Name")

df <- df[!is.na(df$measured_in_time_series_data),]

df <- df[df$measured_in_time_series_data == "yes",]

nrow(df)
45

write.csv(df, "popstats/df_parallel.csv")


# GenomicTimeSeriesReview
Code used to perform a metaanalysis of time-series genomic papers

GENERAL INFORMATION
This README.txt file was updated on December 13th, 2024
A. Paper associated with this archive: Forecasting Genomic Change with Time Series Sequence Data
Citation: (in review)
Brief abstract: Species face increasing evolutionary pressure from anthropogenic disturbances. Humans drive evolution both indirectly through biodiversity and ecosystem disruption and directly through domestication and population management. Human activities also alter species interactions, with important consequences for biodiversity such as emerging disease. Forecasting genomic responses to these multifaceted stressors depends upon the assumption that evolution is, to some extent, predictable. Time series genomic data present unique insights that can inform forecasts of future change in response to the pervasive disturbances of the Anthropocene. In this paper, we review time series genomic literature for general trends and evidence of repeatable evolution. First, we analyze the patterns seen in retrospective genomic time series studies to infer trends that could be used to forecast evolutionary trajectories. We give specific attention to evolution in response to anthropogenic drivers of change and within host-pathogen contexts, which both represent a large share of the literature. Then, we synthesize time series genomic studies on parallel evolution to infer the circumstances in which evolution is repeatable and therefore predictable. Finally, we draw from current advancements in population genomics to predict how time series data will be analyzed in the near future to provide recommendations for both researchers and methods developers.

B. Originators
(redacted for review)

C. Contact information
(redacted for review)

D. Dates of data collection
May 21st 2024 and August 7, 2024

E. Location(s) of data collection
Web of Science and SCOPUS

F. Funding Sources
None


DATA & CODE FILE OVERVIEW
This data repository consist of one supplementary data file, four code scripts, and this README document, with the following data and code filenames and variables
Data files and variables
[describe each column (variable) in each of your data files]
    1. TableS3.xlsx, see metadata tab for column descriptions
    
Code scripts and workflow
    1. 1_FilteringDatatables.sh
    2. 2_CreatingMainDatatable.r
    3. 3_AnalyzingAllData.r
    4. 4_AnalyzingAnthropogenic.r

SOFTWARE VERSIONS
R version 4.2.2 (2022-10-31)
Packages:
dplyr_1.1.4 
ggplot2_3.5.1
ggpubr_0.6.0
ggthemr_1.1.0  
tidyverse_2.0.0
corrplot_0.92  
gridExtra_2.3  
patchwork_1.2.0
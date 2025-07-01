# GenomicTimeSeriesReview
Code used to perform a metaanalysis of time-series genomic papers

GENERAL INFORMATION
This README.txt file was updated on December 13th, 2024
A. Paper associated with this archive: Forecasting Genomic Change with Time Series Sequence Data
Citation: (in review)
Brief abstract: Species face increasing evolutionary pressure from anthropogenic disturbances. Humans drive evolution both indirectly through biodiversity and ecosystem disruption and directly through domestication and population management. Human activities also alter species interactions, with important consequences for biodiversity such as emerging disease. Forecasting genomic responses to these multifaceted stressors depends upon the assumption that evolution is, to some extent, predictable. Time series genomic data present unique insights that can inform forecasts of future change in response to the pervasive disturbances of the Anthropocene. In this paper, we review time series genomic literature for general trends and evidence of repeatable evolution. First, we analyze the patterns seen in retrospective genomic time series studies to infer trends that could be used to forecast evolutionary trajectories. We give specific attention to evolution in response to anthropogenic drivers of change and within host-pathogen contexts, which both represent a large share of the literature. Then, we synthesize time series genomic studies on parallel evolution to infer the circumstances in which evolution is repeatable and therefore predictable. Finally, we draw from current advancements in population genomics to predict how time series data will be analyzed in the near future to provide recommendations for both researchers and methods developers.

B. Originators
Danny Jackson,

C. Contact information
(redacted for review)

D. Dates of data collection
May 21st 2024 and August 7, 2024

E. Location(s) of data collection
Web of Science and SCOPUS

F. Funding Sources
None


# DATA & CODE FILE OVERVIEW
This data repository consist of one supplementary data file, four code scripts, and this README. Below is a file-by-file overview, including brief descriptions of each file's content and purpose.

---

## Data files and variables
### `DataTables/`

#### `Combined_WOS_Scopus_results/`
- **`AugustSearch.xlsx`** – Papers returned from the August 202X literature search.
- **`MaySearch.xlsx`** – Papers returned from the May 202X literature search.


#### `filtered/`
Filtered datasets representing the final dataset used for analyses.
- **`filtered_drift.csv`** – Data on genetic drift across studies
- **`filtered_effectivepopulation.csv`** – Data on effective population size (Ne) across studies
- **`filtered_fst.csv`** – Data on FST across studies
- **`filtered_geneflow.csv`** – Data on gene flow across studies
- **`filtered_inbreeding.csv`** – Data on inbreeding coefficients across studies
- **`filtered_molecularclock.csv`** – Data on molecular clock  across studies
- **`filtered_nucleotidediversity.csv`** – Data on nucleotide diversity across studies
- **`filtered_parallel.csv`** – Data on parallel evolutionary signals across studies
- **`filtered_populationstructure.csv`** – Data on population structure across studies
- **`filtered_screened_papers.csv`** – Summary of which papers passed final screening.
- **`filtered_selection.csv`** – Data on selection across studies
- **`filtered_tajima.csv`** – Data on Tajima's D across studies

#### `originals/`
Raw extracted data and PDFs.
- **`pdfs_all/`** – Folder containing PDFs of all papers analyzed in this study.
- **`allpopstats.csv`** – Full dataset of all extracted metrics before filtering.
- **`popgenstats_increasedecrease.csv`** – Summary of directionality (increase/decrease) across all population genetic metrics.
- **`screened_papers.csv`** – All papers screened with pass/fail outcome.
- **`PopGenTerm.csv` files (e.g., `effective population.csv`)** – Raw data for each population genetics metric.

#### `popstats/`
Cleaned and standardized datasets for analysis.
- **`df_effectivepopulation.csv`**
- **`df_geneflow.csv`**
- **`df_inbreeding.csv`**
- **`df_nucleotidediversity.csv`**
- **`df_parallel.csv`**
- **`df_populationstructure.csv`**
- **`df_selection.csv`**  
*(Each file contains standardized columns: study ID, metric values, direction of change, and relevant metadata.)*

---

### Other Data Files
- **`alldata.csv`** – Master table combining all filtered population genetic metrics from all categories.
- **`files_to_remove.txt`** – List of files removed during cleaning or analysis.
- **`paperinfo.csv`** – Metadata about each paper (e.g., year, journal, study type).
- **`TableS3.xlsx`** – Supplementary table for publication. Column descriptions are provided in the **"metadata"** tab within the file.

---

## Code Files

- **`0.1_downloadpdfs.py`** – Python script to batch download PDFs from DOIs.
- **`0.2_pdfgrep.sh`** – Shell script for searching text strings (grep) within PDFs.
- **`0.3_SearchTermData_Protocol.docx`** – Documentation of search term logic and data collection protocol.
- **`1_FilteringDatatables.sh`** – Shell script for initial filtering of extracted data.
- **`1.1_FilteringDatatables.r`** – R script for cleaning and filtering data (step 1).
- **`1.2_FilteringDatatables.r`** – Alternative or extended R script for additional filtering.
- **`2_CreatingMainDatatable.r`** – Script for merging filtered datasets into a master table.
- **`3_AnalyzingAllData.r`** – Analysis script for running summary and statistical analyses on the full dataset.
- **`4_AnalyzingAnthropogenic.r`** – Analysis script focused on anthropogenic effects on genetic metrics.

---

## Supporting Files

- **`methodfiles.txt`** – List of all method-related documents or files referenced during the review.
- **`reviewfiles.txt`** – Inventory of all data and code files included in this repository.

---
    
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
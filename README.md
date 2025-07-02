# GenomicTimeSeriesReview
Code used to perform a metaanalysis of time-series genomic papers

GENERAL INFORMATION

This README.txt file was updated on July 2nd, 2025

A. Paper associated with this archive: Forecasting Genomic Change with Time Series Sequence Data

Citation: (in review)

Brief abstract: Humans drive species evolution in numerous ways, ranging from the deliberate interventions of domestication to the indirect but far-reaching impacts of climate change. Anticipating how species will adapt to these pressures assumes that evolution is, to some extent, predictable. Evidence of parallel evolution from time series studies can inform such forecasts. In this paper we review time series genomic studies, which directly quantify evolution by sampling populations over time. First, we evaluate the extent to which selection drives parallel adaptation in time series studies. We give specific attention to evolution in response to anthropogenic drivers of change and within host-parasite interactions, which represent major themes in the literature. Then, we analyze the patterns seen in retrospective genomic time series studies to identify how distinct drivers of change influence evolutionary processes such as population structure, gene flow, and genetic diversity. Finally, we draw from current advancements in population genomics to anticipate how time series data will be analyzed in the near future to provide recommendations for both researchers and methods developers.

B. Originators
Danny Jackson, Henrey Deese, Allison Placko, Isabella Weiler, and Sabrina McNew

C. Contact information
dannyjackson@arizona.edu

D. Dates of data collection
May 21st 2024 and August 7, 2024

E. Location(s) of data collection
Web of Science and SCOPUS

F. Funding Sources
None


# DATA & CODE FILE OVERVIEW
This data repository consist of data files, scripts, and this README. Below is a file-by-file overview, including brief descriptions of each file's content and purpose.

---

## Data files and variables
### `DataTables/`

#### `Combined_WOS_Scopus_results/`
- **`AugustSearch.xlsx`** – Papers returned from the August 2024 literature search.
- **`MaySearch.xlsx`** – Papers returned from the May 2024 literature search.


#### `filtered/`
Filtered datasets representing the final dataset used for analyses.
- **`filtered_PopGenTerm.csv`files (e.g., `filtered_effectivepopulation.csv`)**  – Data on each population genetic metric across studies. Columns are:
    - **File.Name** - Name of file in the pdf repository
    - **first_author** - Last name of the first author 
    - **measured_in_time_series** - Binary yes/no, identifies if this metric was measured in time series from genomic data in this paper
    - **level of analysis** - Identifies if the metric was measures across time from one population or multiple populations or was only computed once
    - **increase_decrease** - Did the metric change in a postive or negative direction over time?
    - **method.of.estimating** - What method was used to estimate this metric? (sometimes, not included in all files) 
    - **raw.stats** - What are the raw values of the metric? (sometimes, not included in all files)
- **`filtered_screened_papers.csv`** – Summary of which papers passed final screening. Columns are:
    - **collectedmonth** - Was this article collected in the May or August search?
    - **doi** - The DOI for the paper
    - **pdf** - The full file name of the paper
    - **year** - The year the paper was published
    - **journal** - The journal of publication
    - **volume** - The volume in that journal of the publication
    - **issue** - The issue of the publication
    - **dbs** - Was the article collected from Scopus or Web of Science or both?
    - **authors** - Full author list

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



## Supporting Files

- **`methodfiles.txt`** – List of all method-related documents or files referenced during the review.
- **`reviewfiles.txt`** – Inventory of all data and code files included in this repository.

---
    
## Code scripts and workflow

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

## SOFTWARE VERSIONS
### **R version 4.2.2 (2022-10-31)**
- **Packages:**
    - **dplyr_1.1.4** 
    - **ggplot2_3.5.1** 
    - **ggpubr_0.6.0** 
    - **ggthemr_1.1.0** 
    - **tidyverse_2.0.0** 
    - **corrplot_0.92** 
    - **gridExtra_2.3** 
    - **patchwork_1.2.0** 
    - **Hmisc.5.2.3** 
    - **ggcorrplot.0.1.4.1** 
    - **ggforce.0.4.2** 

### **Python version 3.11.9 (2024-04-02)**
- **Packages:**
    - **doi2pdf 0.1.3**
    - **pandas version 2.2.2**

# GenomicTimeSeriesReview
Code used to perform a metaanalysis of time-series genomic papers

# GENERAL INFORMATION

This README.txt file was updated on August 29th, 2025

A. Paper associated with this archive: Forecasting Genomic Change with Time Series Sequence Data

Citation: (in review)

**Brief abstract:** Humans drive species evolution in numerous ways, ranging from the deliberate interventions of domestication to the indirect but far-reaching impacts of climate change. Anticipating how species will adapt to these pressures assumes that evolution is, to some extent, predictable. Evidence of parallel evolution from time series studies can inform such forecasts. In this paper we review time series genomic studies, which directly quantify evolution by sampling populations over time. First, we evaluate the extent to which selection drives parallel adaptation in time series studies. We give specific attention to evolution in response to anthropogenic drivers of change and within host-parasite interactions, which represent major themes in the literature. Then, we analyze the patterns seen in retrospective genomic time series studies to identify how distinct drivers of change influence evolutionary processes such as population structure, gene flow, and genetic diversity. Finally, we draw from current advancements in population genomics to anticipate how time series data will be analyzed in the near future to provide recommendations for both researchers and methods developers.

**B. Originators:**
Danny Jackson, Henrey Deese, Allison Placko, Isabella Weiler, and Sabrina McNew

**C. Contact information:**
dannyjacksonphd@gmail.com

**D. Dates of data collection:**
May 21st 2024 and August 7, 2024

**E. Location(s) of data collection:**
Web of Science and SCOPUS

**F. Funding Sources:**
None


# DATA & CODE FILE OVERVIEW
This data repository consist of data files, scripts, and this README. Below is a file-by-file overview, including brief descriptions of each file's content and purpose.

---

## Data files and variables
### `DataTables/`

#### `Combined_WOS_Scopus_results/`
- **`AugustSearch.xlsx`** – Papers returned from the August 2024 literature search. Contains eight sheets: 
  - ***invertebrate***
  - ***microbe***
  - ***plant***
  - ***simulation***
  - ***vertebrate***
  - ***virus***
  - ***methods***
  - ***review***
  - **Each sheet contains the following columns:**
    - **0**   -  Article number in full sorted list (used for indexing)
    - **Authors** -  List of authors for the paper
    - **DOI** -  Digital Object Identifier
    - **Abstract**    -   Full abstract of the paper
    - **Type**    -   article, method, or review
    - **Study system**    -   invertebrate, vertebrate, plant, microbe, or simulation
    - **Driver of change**    -   experimental evolution, anthropogenic, host-parasite, natural evolution, simulation
    - **Data type**   -   WGS, poolseq, reduced rep, or metagenomics
    - **Experimental design** -   historical, repeated sampling, or experimental
    - **Time scale years**    -   Length of time between first and last sampling in the genomic time series dataset
    - **Time scale generations**  -   Number of generations between first and last sampling in the genomic time series dataset
    - **Article title**   -   Title of the article
    - **Notes**   -   Any additional notes made by reader
    - **Taxon**   -   Species name

- **`MaySearch.xlsx`** – Papers returned from the May 2024 literature search. Contains eight sheets: 
  - ***virus_covid***
  - ***microbes***
  - ***simulation***
  - ***invertebrate***
  - ***bacteria***
  - ***virus_notcovid***
  - ***vertebrate***
  - ***methods***
  - **Each sheet contains the same columns as in the AugustSearch.xlsx file.**



#### `originals/`
Filtered datasets representing the final dataset used for analyses. File names are all in the format **`[PopGenTerm].csv` e.g. `effective population.csv`**. These files are the same as the files in the Originals folder but without any data from the files in the `files_to_remove.txt` file. Columns are:
- **File.Name** - Name of file in the pdf repository. All files are in the format of [DOI].pdf with all "/" characters replaced with "_", e.g.doi `10.1002.ece3.2402` becomes `10.1002_ece3.2402.pdf`. This naming convention is used to identify articles across all files in this repository.
- **[PopGenTerm]** e.g. **"effective population"** - Binary yes/no, output from pdfgrep that states if the term of interest is present anywhere in the text of the study. This flag was used to determine if a close reading should be done of the paper to extract information on the statistic of interest into this particular datafile.
- **first_author** - Last name of the first author 
- **measured_in_time_series** - Binary yes/no, identifies if this metric was measured in time series from genomic data in this paper
- **level_of_analysis** - Identifies if the metric was measures across time from one population or multiple populations or was only computed once
- **increase_decrease** - Did the metric change in a postive or negative direction over time?
- **method.of.estimating** - What method was used to estimate this metric? (sometimes, not included in all files) 
- **raw.stats** - What are the raw values of the metric? (sometimes, not included in all files)

Additionally, we include metadata for papers that passed final screening. in the file  **`screened_papers.csv`** –  Columns are:
- **collectedmonth** - Was this article collected in the May or August search?
- **doi** - The DOI for the paper
- **pdf** - The full file name of the paper
- **year** - The year the paper was published
- **journal** - The journal of publication
- **volume** - The volume in that journal of the publication
- **issue** - The issue of the publication
- **dbs** - Was the article collected from Scopus or Web of Science or both?
- **authors** - Full author list


#### `filtered/`
Filtered datasets representing the final dataset used for analyses. File names are all in the format **`filtered_[PopGenTerm].csv` e.g. `filtered_effectivepopulation.csv`**. These files are the same as the files in the Originals folder but without any data from the files in the `files_to_remove.txt` file. 
- **`filtered_PopGenTerm.csv`files (e.g., `filtered_effectivepopulation.csv`)**  – Data on each population genetic metric across studies. Columns are the same as in the `originals` folder.

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

### Main Data File
- **`alldata.csv`** – 

This dataset serves as a comprehensive master file that standardizes and compiles population genetic data from multiple categories of analysis. Despite the number of columns, most follow a predictable structure and can be grouped by analysis type or metadata role for easier handling and interpretation.

#### Core Structure

Column names follow the pattern:

[variable]_[column]

- **variable** = type of information (e.g., `first_author`, `raw_stats`, `method_of_estimating`)
- **category** = analysis type or data group (e.g., `ep`, `nd`, `selection`, `drift`, etc.)
- **abbreviation definitions**: `ep` = effective population, `nd` = nucleotide diversity, `selection` = natural selection, `drift` = drift, `fst` = F<sub>ST</sub>, `tajima` = `Tajima's D`, `mc` = molecular clock, `parallel` = parallel evolution, `paperinfo` = metadata obtained from either Scopus or Web of Science during the intial literature search (see files `AugustSearch.xlsx` and `MaySearch.xlsx`).

---

#### Main Categories and Patterns

| **Category** | **Description** | **Common Variables** |
|--------------|------------------|------------------------|
| `ep`, `nd`, `ib`, `ps`, `gf`, `mc` | Genetic metric types | `first_author`, `measured_in_time_series_data`, `hypothesized_driver_of_change`, `level_of_analysis`, `increase_decrease`, `method.of.estimating`, `raw.stats`, `help_needed` |
| `selection` | Natural selection analysis | `author`, `measured_in_time_series_data`, `central_question`, `selection_level_of_analysis`, `selection_coefficients`, `candidate_gene_list`, etc. |
| `drift` | Genetic drift data | `first_author`, `measured_in_time_series_data`, `level_of_analysis`, `hypothesized_driver_of_change`, `did_drift_have_effect`, `raw_stats`, `help_needed`, `notes` |
| `fst`, `tajima` | Specific population statistics | `first_author`, `measured_in_time_series_data`, `level_of_analysis`, `sliding_window_vs_entire_genome`, `candidate_gene_list`, `raw_stats`, `help_needed` |
| `parallel` | Parallel evolution evidence | `author`, `measured_in_time_series_data`, `evidence_of_parallel_evolution`, `snp_evidence`, `gene_protein_evidence`, `parallel_diversity_change`, `notes` |
| `paperinfo` | Study metadata | See columns in `AugustSearch.xlsx` and `MaySearch.xlsx`|

---

### Other Data Files
- **`files_to_remove.txt`** – List of files removed during cleaning or analysis.
- **`paperinfo.csv`** – Metadata about each paper (e.g., year, journal, study type).
- **`TableS3.xlsx`** – Supplementary table for publication. Column descriptions are provided in the **"metadata"** tab within the file.

---



## Supporting Files

- **`methodfiles.txt`** – List of all articles that describe novel methods that were found during the review. These were not comprehensively reviewed, but are retained here for reference.
- **`reviewfiles.txt`** – List of all review articles that were found during the literature search.

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

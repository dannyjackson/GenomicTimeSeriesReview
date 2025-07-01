# Combine files for downstream analyses

# Import necessary libraries

import pandas as pd
from functools import reduce

# ----------------------------
# Step 1: Combine metric files
# ----------------------------

# List of file paths to be merged
files = ['effective population.txt', 'inbreeding coefficient.txt', 'population structure.txt', 'gene flow.txt', 'selection.txt', 'balancing selection.txt', 'purifying selection.txt', 'positive selection.txt', 'drift.txt', 'nucleotide diversity.txt', 'theta.txt', 'fixed.txt', 'fst.txt', 'Tajima.txt', 'molecular clock.txt', 'selection coefficient.txt', 'linkage disequilibrium.txt', 'recombination events.txt', 'gene ontology.txt', 'simulat*.txt']

# Read all the CSV files into a list of DataFrames
dfs = [pd.read_csv(file, sep='\t') for file in files]

# Merge all DataFrames on the first column (index 0)
# Use reduce to apply the merge function across all DataFrames
merged_df = reduce(lambda left, right: pd.merge(left, right, on=left.columns[0]), dfs)

# Save the merged DataFrame to a new CSV file
merged_df.to_csv('merged_output.csv', index=False)

print("Files have been merged and saved as 'merged_output.csv'.")

# --------------------------------------------
# Step 2: Merge with article metadata/codes
# --------------------------------------------

# Load the article metadata
df1 = pd.read_csv('ArticleCodes.csv')

# Load the previously merged metrics file
df2 = merged_df

# Merge the two DataFrames
# 'PDF' from ArticleCodes is matched to 'File Name' in metrics
merged_df = pd.merge(df1, df2, left_on='PDF', right_on='File Name', how='outer')

# Save the merged DataFrame to a new CSV
merged_df.to_csv('merged_file.csv', index=False)


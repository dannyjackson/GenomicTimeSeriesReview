# Code for assessing correlations between presence of variables of interest across papers, and for variables measured in papers of different taxa
# Creates Figure S1 (PCA on correlation matrix) and S2 (PCA on raw data)

# Load in libraries
library(dplyr)
library(ggplot2)
library(Hmisc)
library(ggcorrplot)
library(ggforce)

# Load in the datafile
df = read.csv('merged_file.csv')

# Subset out just the terms that were found in more than than 20 papers

df_corr = subset(df, select = c("Study.system", "effective.population", "population.structure", "gene.flow", "selection", "balancing.selection", "purifying.selection", "positive.selection", "drift", "nucleotide.diversity", "fixed", "fst", "Tajima", "molecular.clock", "selection.coefficient", "linkage.disequilibrium", "recombination.events", "gene.ontology", "simulat."))

# Prepare binary data matrix
## Remove the column with variable names
df_cor <- df_corr[ , -1]

## Convert 'Yes'/'No' to 1/0 for binary analysis
df_binary <- as.data.frame(lapply(df_cor, function(x) ifelse(x == "Yes", 1, 0)))

# Create the correlation matrix

# Compute Spearman correlations (non-parametric)
df_matrix = rcorr(as.matrix(df_binary),type="spearman")

# Extract correlation coefficients (r), sample sizes (n), and p-values (p)
df_matrix_r = data.frame(df_matrix$r)
df_matrix_n = data.frame(df_matrix$n)
df_matrix_p = data.frame(df_matrix$P)

# Save to CSV
write.csv(df_matrix_r, 'correlationmatrix_r.csv')
write.csv(df_matrix_n , 'correlationmatrix_n.csv')
write.csv(df_matrix_p, 'correlationmatrix_p.csv')

# Simple correlation matrix without p-values
cor_matrix <- cor(df_binary)

# PCA on the Correlation Matrix
## Scale the correlation matrix (standardization)
df_scaled <- scale(cor_matrix)

## Perform PCA
pca_result <- prcomp(df_scaled, center = TRUE, scale. = TRUE)

## PCA summary
summary(pca_result)

# PCA loadings 
print(pca_result$rotation)

# PCA scores
print(pca_result$x)


# Extract first two PCs for plotting
pca_df <- data.frame(pca_result$x[, 1:2])


# Plot PCA (Correlation-based)
ggplot(pca_df, aes(x = PC1, y = PC2)) +
  geom_point(size = 3) +
  geom_text(aes(label = rownames(pca_df)), hjust = 0.5, vjust = -0.5) +
  ggtitle("PCA of Correlation Matrix") +
  xlab("Principal Component 1") +
  ylab("Principal Component 2") +
  theme_minimal()



# -----------------------------
# PCA on the Raw Binary Data
# -----------------------------
# Scale the binary data matrix

# Scale the binary data
df_scaled <- scale(df_binary)

# Run PCA
pca_result <- prcomp(df_scaled, center = TRUE, scale. = TRUE)

# PCA summary
summary(pca_result)

# PCA loadings
print(pca_result$rotation)

# PCA scores
print(pca_result$x)


# Extract the sample IDs 
taxa_ids <- df_corr$Study.system

# Create a DataFrame for plotting with the sample IDs and the PCA results
pca_df <- data.frame(SampleID = taxa_ids, pca_result$x[, 1:2])


# Extract the PCA scores (principal components)
pca_scores <- as.data.frame(pca_result$x)

# Create a DataFrame for plotting with the sample IDs and the PCA results
pca_df <- data.frame(Taxa = taxa_ids, pca_result$x[, 1:2])

# Standardize Taxa into Categories
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "microbe ", "microbe", Taxa))

pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "hostpathogen", "microbe", Taxa))

pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "bacteria", "singlecell", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "hostpathogen", "singlecell", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "microbe", "singlecell", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "microbe ", "singlecell", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "virus", "singlecell", Taxa))

pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "invertebrate", "multicellular", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "plant", "multicellular", Taxa))
pca_df <- pca_df %>%
  mutate(Taxa = ifelse(Taxa == "vertebrate", "multicellular", Taxa))

# Plot the PCA result with points colored by 'Taxa' and ellipses (ovals) around the taxa groups
ggplot(pca_df, aes(x = PC1, y = PC2, color = Taxa)) +
  geom_point(size = 3) +
  stat_ellipse(aes(group = Taxa), type = "norm", linetype = 2) +  # Add ellipses
  theme_minimal() +
  labs(title = "PCA of Binary Matrix with Taxa Ellipses",
       x = "PC1",
       y = "PC2")

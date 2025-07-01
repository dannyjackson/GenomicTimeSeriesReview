#!/bin/bash

# ===========================================
# Script: Search PDFs for Key Terms
# Purpose: Identify presence/absence of key terms in PDFs for a systematic review.
# Requirements: pdfgrep
# ===========================================

# === Directories ===

# Files are saved in the format "inbreeding.txt" in the directory DataTables/originals/

# First, move methods and reviews to their own directories -- they are useful references but not part of the analyses

# Define the directory containing PDFs
PDF_DIR="pdfs_all"

mkdir $PDF_DIR/methods $PDF_DIR/reviews

# === Move methods and reviews into their directories ===

while read -r file;
do
mv $file $PDF_DIR/methods/$file
done < methodfiles.txt

while read -r file;
do
mv $file $PDF_DIR/reviews/
done < reviewfiles.txt

cd DataTables/originals

# ===========================================
# Function: Search term in PDFs
# Arguments:
#   $1 = search term
#   $2 = output filename (optional; defaults to "$1.txt")
# ===========================================

while read -r term;
do
echo -e "File Name\t'$term'" > $term.txt

for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q $term "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> $term.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> $term.txt
  fi
done

echo $term >> allstats.txt
awk '{print $2}' $term.txt | sort | uniq -c | awk -v env_var="$term" '{print env_var OFS $0}' >> allstats.txt

done < terms.txt

# search for inbreeding
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "inbreeding" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> inbreeding.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> inbreeding.txt
  fi
done

awk '{print $2}' inbreeding.txt | sort | uniq -c | awk -v env_var="inbreeding" '{print env_var OFS $0}' >> allstats.txt


# fitness

for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q fitness "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> fitness.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> fitness.txt
  fi
done

awk '{print $2}' fitness.txt | sort | uniq -c | awk -v env_var="fitness" '{print env_var OFS $0}' >> allstats.txt

# genetic structure
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "genetic structure" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> genetic\ structure.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> genetic\ structure.txt
  fi
done

awk '{print $2}' genetic\ structure.txt | sort | uniq -c | awk -v env_var="genetic structure" '{print env_var OFS $0}' >> allstats.txt

# spatial structure
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "spatial structure" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> spatial\ structure.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> spatial\ structure.txt
  fi
done

awk '{print $2}' spatial\ structure.txt | sort | uniq -c | awk -v env_var="spatial structure" '{print env_var OFS $0}' >> allstats.txt

# genomic structure
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "genomic structure" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> genomic\ structure.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> genomic\ structure.txt
  fi
done

awk '{print $2}' genomic\ structure.txt | sort | uniq -c | awk -v env_var="genomic structure" '{print env_var OFS $0}' >> allstats.txt


# mutation 
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "mutation" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> mutation.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> mutation.txt
  fi
done

awk '{print $2}' mutation.txt | sort | uniq -c | awk -v env_var="mutation" '{print env_var OFS $0}' >> allstats.txt

# mutation rate
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "mutation rate" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> mutationrate.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> mutationrate.txt
  fi
done

awk '{print $2}' mutationrate.txt | sort | uniq -c | awk -v env_var="mutation rate" '{print env_var OFS $0}' >> allstats.txt

tail allstats.txt
# parallel 
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "parallel" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> parallel.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> parallel.txt
  fi
done

awk '{print $2}' parallel.txt | sort | uniq -c | awk -v env_var="parallel" '{print env_var OFS $0}' >> allstats.txt


# sweep 
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "sweep" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> sweep.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> sweep.txt
  fi
done

awk '{print $2}' sweep.txt | sort | uniq -c | awk -v env_var="sweep" '{print env_var OFS $0}' >> allstats.txt


# hard sweep 
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "hard sweep" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> hardsweep.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> hardsweep.txt
  fi
done

awk '{print $2}' hardsweep.txt | sort | uniq -c | awk -v env_var="hard sweep" '{print env_var OFS $0}' >> allstats.txt

# soft sweep 
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "soft sweep" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> softsweep.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> softsweep.txt
  fi
done

awk '{print $2}' softsweep.txt | sort | uniq -c | awk -v env_var="soft sweep" '{print env_var OFS $0}' >> allstats.txt

# relaxed selection
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "relaxed selection" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> relaxedselection.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> relaxedselection.txt
  fi
done

awk '{print $2}' relaxedselection.txt | sort | uniq -c | awk -v env_var="relaxed selection" '{print env_var OFS $0}' >> allstats.txt

# diversifying selection
for pdf in "$PDF_DIR"/*.pdf; do
  if pdfgrep -i -P -q "diversifying selection" "$pdf"; then
    echo -e "$(basename "$pdf")\tYes" >> diversifyingselection.txt
  else
    echo -e "$(basename "$pdf")\tNo" >> diversifyingselection.txt
  fi
done

awk '{print $2}' diversifyingselection.txt | sort | uniq -c | awk -v env_var="diversifying selection" '{print env_var OFS $0}' >> allstats.txt

# Following this, we followed the directions in the file 0.3_SearchTermData_Protocol.docx to extract data from each of the pdfs
# These data were recorded in the files in the original/ directory
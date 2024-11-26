# Placenta Data Analysis Pipeline

This repository contains scripts for analyzing placenta-related data, focusing on sample types, pregnancy complications, and trimesters at sample collection.
The pipeline is implemented in R and visualizes data proportions using pie and bar charts.

## Table of Contents

1. [Environment Setup](#environment-setup)
2. [Input Data Formats](#input-data-formats)
3. [Pipeline Instructions](#pipeline-instructions)
4. [Output](#output)
5. [Authors and Acknowledgment](#authors-and-acknowledgment)

---

## Environment Setup

### Software Requirements
- R: Ensure R is installed on your system. Download it from [CRAN](https://cran.r-project.org/) Version 4.0 or later recommended.
- RStudio: For enhanced visualization and debugging environment

### Required R packages:
- 'ggplot2' for creating visualizations

Install these packages using the following R commands:
install.packages("ggplot2")

## Input Data Formats

The pipeline processes multiple CSV files. Each CSV file should have the following columns:
1. Placental Sampling: For data about placenta sample types
2. Pregnancy Complications in Data Set (list): For data about pregnancy complications
3. Other Tissue Types in Data Set (list): For data about other tissue types
4. Pregnancy Trimester: For data about trimesters at time of sample collection
Place the input files in a directory accessible by your R environment.

## Pipeline Instructions

1. Clone this repository
  git clone <https://github.com/mrondonu/placenta-database>
  cd <placenta-database>
2. Prepare input data
   Ensure the required CSV files are int he specified paths. Update file paths in the scripts if necessary.
3. Run each script
   Open the script in RSTudio and execute it step by step

Script 1: Placenta Sample Types
This script calculates proportions of placenta sample types and visualizes them as a pie chart.
  1. Update the file path to point to your dataset.
  2. Run the script to clean and process the data.
  3. View and save the generated pie chart.

Script 2: Pregnancy Complications
This script summarizes the proportions of pregnancy complications represented in the dataset.
  1. Update the file path to point to your dataset.
  2. Run the script to clean and categorize complications.
  3 . View and save the pie chart output.

Script 3: Other Tissue Types
This script identifies and visualizes other tissue types represented in the dataset.
  1. Update the file path to point to your dataset.
  2. Execute the script to clean and consolidate tissue types.
  3. View and save the pie chart output.

Script 4: Trimester Data
This script categorizes and visualizes data based on pregnancy trimesters at sample collection.
  1. Update the file path to point to your dataset.
  2. Run the script to clean and group trimester data.
  3. View and save the pie chart output.

## Output
The pipeline generates pie charts for each analyzed dataset, providing a visual representation of proportions:
- Placental Sample Types Pie Chart
- Pregnancy Complications Pie Chart
- Other Tissue Types Pie Chart
- Trimester Data Pie Chart

## Authors and Acknowledgment
This project was created by [Marcia Rondonuwu](https://github.com/mrondonu)

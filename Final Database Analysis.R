# Marcia Rondonuwu 11/17/2024

## This script will show the different placenta sample types represented in the placenta data set

# Read the downloaded spreadsheet data into a data frame
df <- read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Placenta_Sampling_Cleaned.csv")
# -- included the check.names = FALSE parameter to keep R from replacing symbols in column names
spreadsheet_data = read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Placenta_Sampling_Cleaned.csv", check.names = FALSE)

# Load ggplot2 library for creating plots
library(ggplot2)

# Install viridis package to use color palette for charts
install.packages("viridisLite")
library(viridisLite)

# Create a table of the proportion of each species
placental_data = spreadsheet_data$"Placental sampling"

# Correct data

# Define a function to clean and consolidate entries
clean_entries <- function(entry) {
  # Convert to lowercase and trim spaces
  entry <- tolower(trimws(entry))
  
  # Consolidate entries
  if (entry %in% c("na", "none", "n/a", "-")) {
    return("N/A")
  } else if (grepl("placenta", entry)) {
    return("placenta")
  } else if (grepl("trophoblast", entry)) {
    return("trophoblast")
  } else if (grepl("villous|villi", entry)) {
    return("placental villi")
  } else if (grepl("decidua", entry)) {
    return("other")
  } else if (grepl("chorionic", entry)) {
    return("chorionic villus")
  } else {
    return("other")
  }
}

# Clean and consolidate the data
cleaned_data <- sapply(placental_data, clean_entries)

# Table function to summarize the placental samples
placental_freq_table = table(cleaned_data)

# View to pop the table up in RStudio to take a look
View(placental_freq_table)

# Convert table into a data frame
placental_freq_df <- as.data.frame(placental_freq_table)
colnames(placental_freq_df) <- c("Placental Samples Collected", "Frequency")

# Calculate the proportions
placental_freq_df$Proportion <- round(placental_freq_df$Frequency / sum(placental_freq_df$Frequency) * 100, 1)

# Set up ggplot to create a chart
# aes sets aesthetics where x is blank, y is the frequency of each type of placental sample, and fill assigns a color to each sample
plot_sample_types <- ggplot(placental_freq_df, aes(x = "", y = Frequency, fill = `Placental Samples Collected`)) +
  # Create bar segments
  geom_bar(width = 1, stat = "identity") +
  # Turn chart into a pie chart
  coord_polar(theta = "y", start = 0) +
  # Remove axis lines and centering of title
  theme(axis.line = element_blank(),
        plot.title = element_text(hjust=0.5)) +
  # Add labels and title
  labs(fill = "Placental Samples Collected",
       title = "Proportion of Placental Sample Types Represented In Placenta Data Sets") +
  # Add percentages to the legend
  scale_fill_viridis_d(
    option = "plasma", # Assign colors
    labels = paste0(placental_freq_df$`Placental Samples Collected`, " (", placental_freq_df$Proportion, "%)") # Combine data type and proportion
  )

# Print the chart
print(plot_sample_types)

## This script will show the different pregnancy complications represented in the placenta data set

# Read the downloaded spreadsheet data into a data frame
df <- read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Complications_Cleaned.csv")
# -- included the check.names = FALSE parameter to keep R from replacing symbols in column names
spreadsheet_data = read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Complications_Cleaned.csv", check.names = FALSE)

# Load ggplot2 library for creating plots
library(ggplot2)

# Create a table of the proportion of each species
complications_data = spreadsheet_data$"Pregnancy complications in data set (list)"

# Correct data

# Define a function to clean and consolidate entries
clean_complications_entries <- function(entry) {
  # Convert to lowercase for uniformity and trim spaces
  entry <- tolower(trimws(entry))
  
  # Consolidate entries
  if (entry %in% c("na", "none", "n/a", "-", "no", "N/A", "unknown", "NA")) {
    return("N/A")
  } else if (grepl("preeclampsia|pre-eclampsia|preclampsia", entry)) {
    return("preeclampsia")
  } else if (grepl("iugr|intrauterine growth restriction", entry)) {
    return("intrauterine growth restriction")
  } else if (grepl("gestational diabetes|gdma2|Diabetes", entry)) {
    return("gestational diabetes")
  } else if (grepl("pre-term birth|Pre-term labor|pre-term labor|Preterm Birth|preterm birth", entry)) {
    return("pre-term birth")
  } else if (grepl("choriocarcinoma", entry)) {
    return("choriocarcinoma")
  } else {
    return("other")
  }
}

# Split entries containing multiple complications
split_and_clean_complications <- function(entry) {
  # Split the entry by delimiters
  split_entries <- unlist(strsplit(entry, split = "[,;&]", fixed = FALSE))
  
  # Clean and consolidate each individual complication
  cleaned_entries <- sapply(split_entries, clean_complications_entries)
  
  # Return the cleaned complications as a vector
  return(cleaned_entries)
}

# Apply the splitting and cleaning to the dataset
all_complications_data <- unlist(lapply(complications_data, split_and_clean_complications))

# Table function to summarize the pregnancy complications
complications_freq_table = table(all_complications_data)

# View to pop the table up in RStudio to take a look
View(complications_freq_table)

# Convert table into a data frame
complications_freq_df <- as.data.frame(complications_freq_table)
colnames(complications_freq_df) <- c("Pregnancy Complications in Data Set", "Frequency")

# Calculate the proportions
complications_freq_df$Proportion <- round(complications_freq_df$Frequency / sum(complications_freq_df$Frequency) * 100, 1)

# Set up ggplot to create a chart
# aes sets aesthetics where x is blank, y is the frequency of each type of pregnancy complication, and fill assigns a color to each complication
plot_complications <- ggplot(complications_freq_df, aes(x = "", y = Frequency, fill = `Pregnancy Complications in Data Set`)) +
  # Create bar segments
  geom_bar(width = 1, stat = "identity") +
  # Turn chart into a pie chart
  coord_polar(theta = "y", start = 0) +
  # Remove axis lines and centering of title
  theme(axis.line = element_blank(),
        plot.title = element_text(hjust=0.5)) +
  # Add labels and title
  labs(fill = "Pregnancy Complications",
       title = "Proportion of Pregnancy Complications Represented In Placenta Data Sets") +
  # Add percentages to the legend
  scale_fill_viridis_d(
    option = "magma", # Assign colors
    labels = paste0(complications_freq_df$`Pregnancy Complications in Data Set`, " (", complications_freq_df$Proportion, "%)") # Combine data type and proportion
  )

# Print the chart
print(plot_complications)

## This script will show other tissue types represented in the placenta data set

# Read the downloaded spreadsheet data into a data frame
df <- read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Other_Sampling_Cleaned.csv")
# -- included the check.names = FALSE parameter to keep R from replacing symbols in column names
spreadsheet_data = read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Other_Sampling_Cleaned.csv", check.names = FALSE)

# Load ggplot2 library for creating plots
library(ggplot2)

# Create a table of the proportion of each species
other_tissues_data = spreadsheet_data$"Other tissue types in data set (list)"

# Correct data

# Define a list of irrelevant entries
irrelevant_entries <- c("none", "N/A", "no", "-", "0", "n/a", "na", "placenta")

# Convert to lower case for uniformity and trim spaces
other_tissues_data <- tolower(trimws(other_tissues_data))

# Split entries with delimiters (;, ,)
other_tissues_data_split <- unlist(strsplit(other_tissues_data, split = ";|,|and"))

# Remove irrelevant entries
other_tissues_data_clean <- other_tissues_data_split[!other_tissues_data_split %in% irrelevant_entries]

# Consolidate entries
other_tissues_data_clean <- gsub(".*\\bembryonic stem cell\\b.*", "embryonic stem cells", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bembryo\\b.*", "embryo", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\btrophoblast\\b.*", "trophoblast stem cells", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*umbilica.*", "umbilical cord blood", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*decidua.*", "decidua", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*peripheral.*", "peripheral blood", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*liver.*", "liver", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*brain.*", "brain", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*lung.*", "lung", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*heart.*", "heart", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*bone marrow.*", "bone marrow", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bblastocyst\\b.*", "blastocyst", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bpluripotent stem cell\\b.*", "pluripotent stem cells", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*epithelial.*", "epithelial cells", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bendomet\\b.*", "endometrial tissue", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*yolk sac.*", "yolk sac", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bfetal\\b.*", "fetal tissue", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\bstem cell\\b.*", "other stem cells", other_tissues_data_clean)
other_tissues_data_clean <- gsub(".*\\buter\\b.*", "uterine tissue", other_tissues_data_clean)

# Replace all other entries with "other"
valid_categories <- c("embryonic stem cells", "embryo", "trophoblast stem cells", "umbilical cord blood",
                      "decidua", "peripheral blood", "liver", "brain", "lung", "heart", "bone marrow",
                      "blastocyst", "pluripotent stem cells", "epithelial cells", "endometrial tissue", "yolk sac",
                      "fetal tissue", "other stem cells", "uterine tissue")
other_tissues_data_clean <- ifelse(other_tissues_data_clean %in% valid_categories, other_tissues_data_clean, "other")

# Table function to summarize the other tissues
other_tissues_freq_table = table(other_tissues_data_clean)

# View to pop the table up in RStudio to take a look
View(other_tissues_freq_table)

# Convert table into a data frame
other_tissues_freq_df <- as.data.frame(other_tissues_freq_table)
colnames(other_tissues_freq_df) <- c("Other Tissue Types in Data Set", "Frequency")

# Calculate the proportions
other_tissues_freq_df$Proportion <- round(other_tissues_freq_df$Frequency / sum(other_tissues_freq_df$Frequency) * 100, 1)

# Set up ggplot to create a chart
# aes sets aesthetics where x is blank, y is the frequency of each type of tissue, and fill assigns a color to each tissue
plot_other_tissues <- ggplot(other_tissues_freq_df, aes(x = "", y = Frequency, fill = `Other Tissue Types in Data Set`)) +
  # Create bar segments
  geom_bar(width = 1, stat = "identity") +
  # Turn chart into a pie chart
  coord_polar(theta = "y", start = 0) +
  # Remove axis lines and centering of title
  theme(axis.line = element_blank(),
        plot.title = element_text(hjust=0.5)) +
  # Add labels and title
  labs(fill = "Other Tissue Types Collected",
       title = "Proportion of Other Tissue Types Represented In Placenta Data Sets") +
  # Add percentages to the legend
  scale_fill_viridis_d(
    option = "inferno", # Assign colors
    labels = paste0(other_tissues_freq_df$`Other Tissue Types in Data Set`, " (", other_tissues_freq_df$Proportion, "%)") # Combine data type and proportion
  )

# Print the chart
print(plot_other_tissues)

## This script will show the pregnancy trimester at sample collection represented in the placenta data set

# Read the downloaded spreadsheet data into a data frame
df <- read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Trimester_Cleaned.csv")
# -- included the check.names = FALSE parameter to keep R from replacing symbols in column names
spreadsheet_data = read.csv("C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Weekly Progress Report Module 5/Placenta_Study_Information_Trimester_Cleaned.csv", check.names = FALSE)

# Load ggplot2 library for creating plots
library(ggplot2)

# Create a table
trimester_data = spreadsheet_data$"Pregnancy trimester"


# Correct data

# Define a function to clean and categorize the data
clean_trimester_data <- function(entry) {
  # Convert to lower case for uniformity and trim spaces
  entry <- tolower(trimws(entry))
  
  # Match terms to pregnancy trimesters
  if (grepl("\\b(1st|first|<13 weeks|d[0-9]|days? [1-9]|<4 months|\\b1\\b)\\b", entry)) {
    return("First Trimester")
  } else if (grepl("\\b(2nd|second|13-26 weeks|d1[0-6]|<7 months|\\b2\\b)\\b", entry)) {
    return("Second Trimester")
  } else if (grepl("\\b(3rd|third|27-40 weeks|<10 months|\\b3\\b|term)\\b", entry)) {
    return("Third Trimester")
  } else if (grepl("\\b(preterm|<35 weeks|premature)\\b", entry)) {
    return("Preterm")
  } else if (grepl("\\b(post birth|pospartum)\\b", entry)) {
    return("Postnatal")
  } else if (grepl("\\b(full|term|gestational day)\\b", entry)) {
    return("Full Term")
  } else if (grepl("^e[0-9]+\\.?[0-9]*$", entry)) {
    numeric_value <- as.numeric(sub("e", "", entry))
    if (numeric_value >= 0 && numeric_value <= 6.5) {
      return("Early Development Mice (e0–e6.5)")
    } else if (numeric_value > 6.5 && numeric_value <= 10) {
      return("Mid Development Mice (e6.5–e10)")
    } else if (numeric_value > 10 && numeric_value <= 14.5) {
      return("Late Development Mice (e10–e14.5)")
    } else if (numeric_value > 14.5 && numeric_value <= 18.5) {
      return("Pre-Term Mice (e14.5–e18.5)")
    } else if (numeric_value > 18.5) {
      return("Term Mice (e18.5 and beyond)")
    }
  } else if (grepl("\\b(unreported|n/a|dont have access|varying|not provided|na|none|-|unknown|no|not listed|
                   not mentioned|na: in|n/a samples from mice|n/a samples are from mice|n/a for rats|multiple|
                   it just states fetal|embryo|embryos?|rat pregnancy)\\b", entry)) {
    return("Unreported")
  } else {
    return("Other/Uncategorized")
  }
}

# Split entries containing multiple complications
split_and_clean_trimesters <- function(entry) {
  # Split the entry by delimiters
  split_entries <- unlist(strsplit(entry, split = "[,;&/-]", fixed = FALSE))
  
  # Clean and consolidate each individual complication
  cleaned_entries <- sapply(split_entries, clean_trimester_data)
  
  # Return the cleaned complications as a vector
  return(cleaned_entries)
}

# Apply the splitting and cleaning to the dataset
all_trimester_data <- unlist(lapply(trimester_data, split_and_clean_trimesters))

# Table function to summarize the other tissues
trimester_freq_table = table(all_trimester_data)

# View to pop the table up in RStudio to take a look
View(trimester_freq_table)

# Convert table into a data frame
trimester_df <- as.data.frame(trimester_freq_table)
colnames(trimester_df) <- c("Trimester", "Frequency")

# Define the desired order of categories
desired_order <- c(
  "Early Development Mice (e0–e6.5)",
  "Mid Development Mice (e6.5–e10)",
  "Late Development Mice (e10–e14.5)",
  "Pre-Term Mice (e14.5–e18.5)",
  "First Trimester",
  "Second Trimester",
  "Third Trimester",
  "Preterm",
  "Full Term",
  "Postnatal",
  "Other/Uncategorized",
  "Unreported"
)

# Convert the "Trimester" column to a factor with the specified order
trimester_df$Trimester <- factor(trimester_df$Trimester, levels = desired_order)

# Calculate the proportions
trimester_df$Proportion <- round(trimester_df$Frequency / sum(trimester_df$Frequency) * 100, 1)

# Plot the frequency of pregnancy trimesters
plot_trimester <- ggplot(data = trimester_df, aes(x = Trimester, y = Frequency, fill = Trimester)) +
  geom_bar(stat = "identity", color = "black") + # Add black border to bars
  scale_fill_viridis_d(option = "rocket") + # Use a color palette
  geom_text(aes(label = paste0(Proportion, "%")), # Add percentages as labels
            vjust = -0.5, size = 3) + # Adjust vertical position and size of text
  xlab("Pregnancy Stage") +
  ylab("Frequency") +
  ggtitle("Frequency of Pregnancy Stages in Placenta Data Sets") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10), # Rotate x-axis labels
    axis.title.x = element_text(size = 12),
    axis.title.y = element_text(size = 12),
    plot.title = element_text(size = 14, face = "bold"),
    legend.position = "none" # Remove legend it's redundant
  )

# Print the chart
print(plot_trimester)

# Set the output directory
output_direc <- "C:/Users/marci/OneDrive/Documents/ASU/BIO 498/Manuscript Charts "

# Save 1st plot in JPEG format
ggsave(paste0(output_direc, "plot_sample_types.jpg"), plot = plot_sample_types, width = 10, height = 6)

# Save 2nd plot in JPEG format
ggsave(paste0(output_direc, "plot_complications.jpg"), plot = plot_complications, width = 10, height = 6)

# Save 3rd plot in JPEG format
ggsave(paste0(output_direc, "plot_other_tissues.jpg"), plot = plot_other_tissues, width = 10, height = 6)

# Save 4th plot in JPEG format
ggsave(paste0(output_direc, "plot_trimester.jpg"), plot = plot_trimester, width = 22, height = 6)

# Print a message to confirm the plot has been saved
cat("Plot saved in:", output_direc)


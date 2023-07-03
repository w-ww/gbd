# Load required libraries
library(ggplot2)
library(dplyr)
# Rate data
rate_data <- read.csv("/Users/i045835/gbd/Chart/P factors by age groups 2019/rate.csv")

# Calculate the sum of val for each age group
age_sums <- rate_data %>% group_by(age) %>% summarise(total = sum(val))

# Calculate the percentage of each cause within each age group
rate_data <- rate_data %>% 
  left_join(age_sums, by = "age") %>% 
  mutate(percentage = val / total * 100) %>%
  select(-total)

# Convert age column to factor with the correct order
age_levels <- c("<5", "5-9", "10-14", "15-19", "20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75-79","80-84",
"85-89","90-94","95+")
rate_data$age <- factor(rate_data$age, levels = age_levels)

# Convert cause column to factor with the correct order
cause_levels <- c("G6PD deficiency", "Myocarditis", "Chagas disease",
 "Other hemoglobinopathies and hemolytic anemias", "Thalassemias", 
 "Endocrine, metabolic, blood, and immune disorders", "Endocarditis", 
  "Other non-rheumatic valve diseases",
  "Non-rheumatic calcific aortic valve disease", "Non-rheumatic degenerative mitral valve disease", 
  "Rheumatic heart disease", "Alcoholic cardiomyopathy", "Hypertensive heart disease", 
  "Ischemic heart disease", "Other cardiomyopathy", "Congenital heart anomalies")
rate_data$cause <- factor(rate_data$cause, levels = cause_levels)

# Function to add "%" suffix to y-axis labels
percent_format <- function(x) {
  paste0(x, "%")
}

# Create proportional histogram chart with percentage values for y-axis
histogram_plot <- ggplot(rate_data, aes(x = age, y = percentage, fill = cause)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Proportional Histogram of Heart Failure Rates in Asia", x = "Age group", y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1), legend.title = element_blank(),
        axis.line.x = element_line(size = 0.7, color = "darkgray"), # Bolder x-axis line
        axis.line.y = element_line(size = 0.7, color = "darkgray"),  # Bolder y-axis line
        axis.ticks = element_line(color = "darkgray"), # Dark gray tick marks
        panel.grid.major = element_blank(), # Remove major gridlines
        panel.grid.minor = element_blank()  # Remove minor gridlines
  ) +
  scale_fill_manual(values = c( "#BE0A1E","#E82323", "#F5553E", "#F8AB90", 
"#194D28", "#297237","#55A149","#7FC36A",
   "#A7D597", "#13347F", "#165CA7", "#337FBB", 
  "#599CCF", "#8CC0DD", "#BAD4EC", "#E2F3FC") )+
  scale_y_continuous(expand = expansion(mult = c(0, 0)), # Remove the gap between the whole heatmap and the x-axis
                     limits = c(0, 100), # Remove the portion above 100 on the y-axis
                     labels = percent_format) # Add "%" suffix to the labels on the y-axis
# Print the histogram plot
print(histogram_plot)

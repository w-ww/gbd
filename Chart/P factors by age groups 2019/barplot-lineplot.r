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

# Create proportional histogram chart with percentage values for y-axis
histogram_plot <- ggplot(rate_data, aes(x = age, y = percentage, fill = cause)) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Proportional Histogram of Heart Failure Rates in Asia", x = "Age", y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1), legend.title = element_blank()) +
  scale_fill_manual(values = c("darkblue", "darkred", "darkgreen", "darkorange", "purple", "pink", "cyan", "yellow", "magenta", "coral", "violet", "skyblue", "steelblue", "tan", "brown", "olivedrab"))

# Print the histogram plot
print(histogram_plot)
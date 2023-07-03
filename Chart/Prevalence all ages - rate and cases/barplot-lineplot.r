# Load required libraries
library(ggplot2)
library(scales)

# Read data
rate_data <- read.csv("/Users/i045835/gbd/Chart/Prevalence all ages - rate and cases/Prevalence all ages - rate.csv")
number_data <- read.csv("/Users/i045835/gbd/Chart/Prevalence all ages - rate and cases/Prevalence all ages - cases.csv")

# Convert age column to factor with the correct order
number_data$age <- factor(number_data$age, levels = c("<5", "5-9", "10-14", "15-19", "20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75-79","80-84",
"85-89","90-94","95+"))
rate_data$age <- factor(rate_data$age, levels = c("<5", "5-9", "10-14", "15-19","20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65-69","70-74","75-79","80-84",
"85-89","90-94","95+"))

# Create the combined plot
combined_plot <- ggplot() +
  geom_bar(
    data = number_data,
    aes(x = age, y = val, fill = sex),
    stat = "identity",
    position = "dodge",
    width = 0.7
  ) +
  geom_errorbar(
    data = number_data,
    aes(x = age, ymin = lower, ymax = upper, group = sex),
    width = 0.2,
    position = position_dodge(0.7)
  ) +
  geom_line(
    data = rate_data,
    aes(x = age, y = val * 100, group = sex, color = sex),
    size = 0.7,
    inherit.aes = FALSE
  ) +
  scale_color_manual(values = c("blue", "red")) +
  scale_fill_manual(values = c("darkblue", "darkred")) +
  geom_ribbon(
    data = rate_data,
    aes(x = age, ymin = lower * 100, ymax = upper * 100, fill = sex, group = sex),
    alpha = 0.5,
    inherit.aes = FALSE,
    show.legend = FALSE
  ) +
  scale_y_continuous(
    name = "Number",
    sec.axis = sec_axis(~ . / 1000, name = "Rate"),
    expand = c(0, 0),
    labels = comma_format()
  ) +
  scale_x_discrete(expand = c(0, 0)) +
  geom_segment(aes(x = 0.5, xend = 5.5, y = 0, yend = 0), color = "black") +
  labs(title = "Prevalence of Heart Failure in Asia", x = "Age Group") +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    axis.line.y = element_line(color = "black", size = 0.5),
    axis.line.x = element_line(color = "black", size = 0.5),
    panel.grid = element_blank(),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.ticks = element_line(color = "black", size = 0.5),
    axis.ticks.length = unit(0.15, "cm")
  ) +
  guides(fill = guide_legend(title = "Number", order = 1),
         color = guide_legend(title = "Rate", order = 2)) +
  theme(legend.position = "top")

# Print the combined plot
print(combined_plot)

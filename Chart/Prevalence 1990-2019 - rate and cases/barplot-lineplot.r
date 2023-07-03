rate_data <- read.csv("/Users/i045835/gbd/Chart/Prevalence 1990-2019 - rate and cases/rate.csv")
number_data <- read.csv("/Users/i045835/gbd/Chart/Prevalence 1990-2019 - rate and cases/cases.csv")
library(ggplot2)

# Combine rate and number data
# combined_data <- bind_rows(rate_data, number_data)

# Create the combined plot
combined_plot <- ggplot() +
  geom_bar(
    data = number_data,
    aes(x = year, y = val, fill = sex),
    stat = "identity",
    position = "dodge",
    width = 0.7
  ) +
  geom_errorbar(
    data = number_data,
    aes(x = year, ymin = lower, ymax = upper, group = sex),
    width = 0.2,
    position = position_dodge(0.7)
  ) +
  geom_line(
    data = rate_data,
    aes(x = year, y = val * 10000, group = sex, color = sex),
    size = 0.7,
    inherit.aes = FALSE
  ) +
  scale_color_manual(values = c("blue", "red")) +
  scale_fill_manual(values = c("darkblue", "darkred")) +
  geom_ribbon(
    data = rate_data,
    aes(x = year, ymin = lower * 10000, ymax = upper * 10000, fill = sex, group = sex),
    alpha = 0.5,
    inherit.aes = FALSE,
    show.legend = FALSE
  ) +
  scale_y_continuous(
    name = "Number",
    sec.axis = sec_axis(~ . / 1000, name = "Rate"),
    expand = c(0, 0)
  ) +
  scale_x_continuous(expand = c(0, 0), breaks = 1990:2019) +
  geom_segment(aes(x = 1989.5, xend = 2019.5, y = 0, yend = 0), color = "black") +
  labs(title = "Prevalence of Heart Failure in Asia", x = "Year") +
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

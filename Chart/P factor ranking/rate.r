
# Load necessary libraries
library(dplyr)
library(ggplot2)

# Load data
data <- read.csv("/Users/i045835/gbd/Chart/P factor ranking/rate.csv")

# Remove rows with N/A values in the cause column
# Remove rows with N/A or empty values in the cause column
data_cleaned <- data %>% filter(!is.na(cause) & cause != "")
data_cleaned <- data_cleaned %>% filter(!is.na(location) & location != "")

# Rank causes by val
data_ranked <- data_cleaned %>%
  group_by(location) %>%
  mutate(rank = rank(val))

# Reorder location with Global and Asia at the leftmost positions
data_ranked$location <- factor(data_ranked$location, levels = c("Global", "Asia", setdiff(unique(data_ranked$location), c("Global", "Asia"))))

# Reorder cause based on Global rank
# data_ranked$cause <- factor(data_ranked$cause, levels = data_ranked %>% filter(location == "Global") %>% arrange(rank) %>% pull(cause))

# Reorder cause based on Global rank in descending order
data_ranked$cause <- factor(data_ranked$cause, levels = data_ranked %>% filter(location == "Global") %>% arrange(-rank) %>% pull(cause))


# # Custom color scale
# custom_color_scale <- scale_fill_gradientn(colors = c("darkred", "darkorange", "goldenrod", "lightgreen", "darkgreen"),
#                                            breaks = c(1, 3, 6, 9, 12, 16),
#                                            limits = c(1, 16))
# Custom color scale
custom_color_scale <- scale_fill_gradient(low = "red", high = "white",
                                          breaks = c(1, 3, 6, 9, 12, 16),
                                          limits = c(1, 16))
# # Create the heatmap plot
# heatmap_plot <- ggplot(data_ranked, aes(x = location, y = cause, fill = rank)) +
#   geom_tile(color = "white") +
#   geom_text(aes(label = rank), size = 1, color = "black") +
#   custom_color_scale +
#   theme(axis.text.x = element_text(angle = 90, face = "bold",hjust = 1, vjust = 0.9, size = 3),
#         axis.text.y = element_text(face = "bold",size = 5),
#         axis.title.x = element_blank(),
#         axis.title.y = element_blank(),
#         panel.spacing = unit(0, "lines"),
#         panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank(),
#         plot.margin = margin(5, 5, 5, 5, "pt"),
#         panel.background = element_blank()) +
#   labs(fill = "Rank")
# Create the heatmap plot
heatmap_plot <- ggplot(data_ranked, aes(x = location, y = cause, fill = rank)) +
  geom_tile(color = "white") +
  geom_text(aes(label = rank), size = 1, color = "black") +
  custom_color_scale +
  theme(axis.text.x = element_text(angle = 90, hjust = 0, vjust = 0.5, size = 7, face = "bold"),
        axis.text.y = element_text(size = 7, face = "bold"),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        plot.margin = margin(t = 20, b = 20, l = 20, r = 20),
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x.top = element_text(face = "bold"),
        axis.text.x.bottom = element_blank(),
        panel.spacing = unit(0, "lines"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank()) +
  labs(fill = "Rank") +
  scale_x_discrete(position = "top")

plot(heatmap_plot)

# Save the plot as a high-resolution image
ggsave("heatmap_plot.png", plot = heatmap_plot, dpi = 300, width = 10, height = 6, units = "in")
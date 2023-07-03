Use R to draw a chart with reference to the following Demo code. 

The chart displays a bar plot for the following number data and a line plot with shaded ribbons for the following rate data. The left y-axis shows the number, and the right y-axis shows the rate. The error bars and ribbons represent the 95% confidence interval.

```
Rate data

| measure    | location | sex    | age              | cause      | rei           | metric | year | val         | upper       | lower       |
|------------|----------|--------|------------------|------------|---------------|--------|------|-------------|-------------|-------------|
| Prevalence | Asia     | Male   | Age-standardized | All causes | Heart failure | Rate   | 1990 | 794.5773316 | 984.6805023 | 644.6781891 |
| Prevalence | Asia     | Female | Age-standardized | All causes | Heart failure | Rate   | 1990 | 709.6358236 | 883.3620545 | 576.7759091 |
| Prevalence | Asia     | Male   | Age-standardized | All causes | Heart failure | Rate   | 1991 | 791.2748802 | 979.3623096 | 641.9758687 |
| Prevalence | Asia     | Female | Age-standardized | All causes | Heart failure | Rate   | 1991 | 709.2964869 | 881.910374  | 576.3755764 |
| Prevalence | Asia     | Male   | Age-standardized | All causes | Heart failure | Rate   | 1992 | 788.4146554 | 974.5957407 | 639.6827008 |
| Prevalence | Asia     | Female | Age-standardized | All causes | Heart failure | Rate   | 1992 | 708.5596607 | 880.4457866 | 576.4981448 |
| Prevalence | Asia     | Male   | Age-standardized | All causes | Heart failure | Rate   | 1993 | 786.095158  | 970.5557559 | 638.9928931 |
| Prevalence | Asia     | Female | Age-standardized | All causes | Heart failure | Rate   | 1993 | 707.6428165 | 879.5404154 | 577.0276736 |
| Prevalence | Asia     | Male   | Age-standardized | All causes | Heart failure | Rate   | 1994 | 784.5147061 | 967.4128658 | 637.3162299 |
| Prevalence | Asia     | Female | Age-standardized | All causes | Heart failure | Rate   | 1994 | 706.5852099 | 877.7929193 | 576.0289315 |


```


```
Number Data
| measure    | location | sex    | age      | cause      | rei           | metric | year | val         | upper       | lower       |
|------------|----------|--------|----------|------------|---------------|--------|------|-------------|-------------|-------------|
| Prevalence | Asia     | Male   | All ages | All causes | Heart failure | Number | 1990 | 6396154.74  | 7990295.899 | 5176250.769 |
| Prevalence | Asia     | Female | All ages | All causes | Heart failure | Number | 1990 | 6063705.073 | 7476887.648 | 4939095.543 |
| Prevalence | Asia     | Male   | All ages | All causes | Heart failure | Number | 1991 | 6563615.023 | 8189306.827 | 5307334.932 |
| Prevalence | Asia     | Female | All ages | All causes | Heart failure | Number | 1991 | 6247642.436 | 7688742.594 | 5087465.558 |
| Prevalence | Asia     | Male   | All ages | All causes | Heart failure | Number | 1992 | 6740371.167 | 8398691.416 | 5451151.686 |
| Prevalence | Asia     | Female | All ages | All causes | Heart failure | Number | 1992 | 6435600.886 | 7908623.87  | 5235006.515 |
| Prevalence | Asia     | Male   | All ages | All causes | Heart failure | Number | 1993 | 6924422.887 | 8615991.58  | 5603729.412 |
| Prevalence | Asia     | Female | All ages | All causes | Heart failure | Number | 1993 | 6626372.059 | 8131761.132 | 5386242.635 |
| Prevalence | Asia     | Male   | All ages | All causes | Heart failure | Number | 1994 | 7123044.308 | 8851469.193 | 5769142.452 |
| Prevalence | Asia     | Female | All ages | All causes | Heart failure | Number | 1994 | 6825051.659 | 8363219.625 | 5556339.093 |


```

```
Demo code

library(ggplot2)

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
    expand = c(0, 0)
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

print(combined_plot)


```

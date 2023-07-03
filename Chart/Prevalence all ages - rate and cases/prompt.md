Draw one chart with R. The chart includes:
1, bar plot with the left y-axis for val and error bars indicates the 95% confidence interval based on the following Number data
2, line plot with the right y-axis for val and shaded ribbons indicates indicates the 95% UI based on the following Rate data


```
Rate data

| measure    | location | sex    | age   | cause      | rei           | metric | year | val         | upper       | lower       |
|------------|----------|--------|-------|------------|---------------|--------|------|-------------|-------------|-------------|
| Prevalence | Asia     | Male   | <5    | All causes | Heart failure | Rate   | 2019 | 33.51390142 | 45.53309823 | 24.27142658 |
| Prevalence | Asia     | Female | <5    | All causes | Heart failure | Rate   | 2019 | 31.59662776 | 43.27600024 | 22.54967976 |
| Prevalence | Asia     | Male   | 05-9  | All causes | Heart failure | Rate   | 2019 | 29.92638071 | 45.28838645 | 19.09190682 |
| Prevalence | Asia     | Female | 05-9  | All causes | Heart failure | Rate   | 2019 | 28.33937652 | 42.86284458 | 18.01887542 |
| Prevalence | Asia     | Male   | 10-14 | All causes | Heart failure | Rate   | 2019 | 19.39611274 | 29.84556156 | 12.15921481 |
| Prevalence | Asia     | Female | 10-14 | All causes | Heart failure | Rate   | 2019 | 18.9985793  | 29.2851995  | 12.04868898 |
| Prevalence | Asia     | Male   | 15-19 | All causes | Heart failure | Rate   | 2019 | 17.25565371 | 23.62713891 | 11.80356825 |
| Prevalence | Asia     | Female | 15-19 | All causes | Heart failure | Rate   | 2019 | 16.86518812 | 23.42067389 | 11.58082887 |

```

```
Number data

| measure    | location | sex    | age         | cause      | rei           | metric | year | val         | upper       | lower       |
|------------|----------|--------|-------------|------------|---------------|--------|------|-------------|-------------|-------------|
| Prevalence | Asia     | Male   | <5    | All causes | Heart failure | Number | 2019 | 61864.30655 | 84050.89913 | 44803.3476  |
| Prevalence | Asia     | Female | <5    | All causes | Heart failure | Number | 2019 | 53161.68713 | 72812.36475 | 37940.09378 |
| Prevalence | Asia     | Male   | 5-9   | All causes | Heart failure | Number | 2019 | 55343.87848 | 83753.36064 | 35307.31568 |
| Prevalence | Asia     | Female | 5-9   | All causes | Heart failure | Number | 2019 | 47849.35859 | 72371.37412 | 30423.80381 |
| Prevalence | Asia     | Male   | 10-14 | All causes | Heart failure | Number | 2019 | 36153.40039 | 55630.65917 | 22664.17852 |
| Prevalence | Asia     | Female | 10-14 | All causes | Heart failure | Number | 2019 | 32316.52014 | 49814.02686 | 20494.77984 |
| Prevalence | Asia     | Male   | 15-19 | All causes | Heart failure | Number | 2019 | 31922.99289 | 43710.25289 | 21836.62419 |
| Prevalence | Asia     | Female | 15-19 | All causes | Heart failure | Number | 2019 | 28875.38816 | 40099.22954 | 19827.88016 |

```

The chart displays a bar plot for the number data and a line plot with shaded ribbons for the rate data. The left y-axis shows the number, and the right y-axis shows the rate. The error bars and ribbons represent the 95% confidence interval.
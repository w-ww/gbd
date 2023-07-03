Use R to draw a Proportional histogram chart for the following rate data. 
one bar for each age, the bar consists of causes.

This code creates a proportional histogram chart for the given rate data, displaying the percentage of heart failure rates in Asia by cause and age group. The chart has one bar for each age ("<5" and "10-14"), with each bar consisting of different causes. The causes are distinguished by different colors. The values of the y-axis represent the percentage of causes within each age group.

```
Rate data

| measure    | location | sex  | age         | cause                                               | rei           | metric | year | val     | upper   | lower   |
|------------|----------|------|-------------|-----------------------------------------------------|---------------|--------|------|---------|---------|---------|
| Prevalence | Asia     | Both | <5   | Rheumatic heart disease                             | Heart failure | Rate   | 2019 | 1.2564  | 2.0399  | 0.6836  |
| Prevalence | Asia     | Both | <5   | Ischemic heart disease                              | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Hypertensive heart disease                          | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Non-rheumatic degenerative mitral valve disease     | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Other non-rheumatic valve diseases                  | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | G6PD deficiency                                     | Heart failure | Rate   | 2019 | 0.0469  | 0.0715  | 0.0290  |
| Prevalence | Asia     | Both | <5   | Other hemoglobinopathies and hemolytic anemias      | Heart failure | Rate   | 2019 | 0.0164  | 0.0249  | 0.0102  |
| Prevalence | Asia     | Both | <5   | Congenital heart anomalies                          | Heart failure | Rate   | 2019 | 24.7841 | 35.8019 | 16.6557 |
| Prevalence | Asia     | Both | <5   | "Endocrine, metabolic, blood, and immune disorders" | Heart failure | Rate   | 2019 | 0.5307  | 0.8023  | 0.3301  |
| Prevalence | Asia     | Both | <5   | Alcoholic cardiomyopathy                            | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Myocarditis                                         | Heart failure | Rate   | 2019 | 1.7707  | 2.8033  | 1.0172  |
| Prevalence | Asia     | Both | <5   | Other cardiomyopathy                                | Heart failure | Rate   | 2019 | 1.4836  | 2.3163  | 0.8680  |
| Prevalence | Asia     | Both | <5   | Non-rheumatic calcific aortic valve disease         | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Chagas disease                                      | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | <5   | Endocarditis                                        | Heart failure | Rate   | 2019 | 0.2879  | 0.4373  | 0.1802  |
| Prevalence | Asia     | Both | <5   | Thalassemias                                        | Heart failure | Rate   | 2019 | 1.4327  | 2.1801  | 0.8824  |
| Prevalence | Asia     | Both | 10-14| Rheumatic heart disease                             | Heart failure | Rate   | 2019 | 2.0455  | 3.7201  | 0.9325  |
| Prevalence | Asia     | Both | 10-14| Ischemic heart disease                              | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Hypertensive heart disease                          | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Non-rheumatic degenerative mitral valve disease     | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Other non-rheumatic valve diseases                  | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| G6PD deficiency                                     | Heart failure | Rate   | 2019 | 0.1146  | 0.1915  | 0.0556  |
| Prevalence | Asia     | Both | 10-14| Other hemoglobinopathies and hemolytic anemias      | Heart failure | Rate   | 2019 | 0.0447  | 0.0747  | 0.0217  |
| Prevalence | Asia     | Both | 10-14| Congenital heart anomalies                          | Heart failure | Rate   | 2019 | 11.8754 | 21.8666 | 5.8790  |
| Prevalence | Asia     | Both | 10-14| "Endocrine, metabolic, blood, and immune disorders" | Heart failure | Rate   | 2019 | 0.1928  | 0.3200  | 0.0957  |
| Prevalence | Asia     | Both | 10-14| Alcoholic cardiomyopathy                            | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Myocarditis                                         | Heart failure | Rate   | 2019 | 1.3383  | 2.1930  | 0.6914  |
| Prevalence | Asia     | Both | 10-14| Other cardiomyopathy                                | Heart failure | Rate   | 2019 | 1.6761  | 2.7130  | 0.8987  |
| Prevalence | Asia     | Both | 10-14| Non-rheumatic calcific aortic valve disease         | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Chagas disease                                      | Heart failure | Rate   | 2019 | 0.0000  | 0.0000  | 0.0000  |
| Prevalence | Asia     | Both | 10-14| Endocarditis                                        | Heart failure | Rate   | 2019 | 0.1592  | 0.2617  | 0.0802  |
| Prevalence | Asia     | Both | 10-14| Thalassemias                                        | Heart failure | Rate   | 2019 | 0.5625  | 0.9398  | 0.2754  |

```


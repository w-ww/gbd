setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
#  install.packages('ggmap')
#  install.packages('rgdal')
#  install.packages('maps')
#  install.packages('dplyr')
library(ggmap)
library(rgdal)
library(maps)
library(dplyr)

EC <- read.csv('EC_nation.csv',header = T)  ## 读取我们的数据
ASR_2019 <- subset(EC,EC$year==2019 & 
                     EC$age=='Age-standardized' & 
                     EC$metric== 'Rate' &
                     EC$measure=='Incidence') ## 获取2019年EC年龄校正后发病率
ASR_2019 <- ASR_2019[,c(2,8,9,10)]
ASR_2019$val <- round(ASR_2019$val,1) ###保留一位小数点
ASR_2019$lower <- round(ASR_2019$lower,1) ###保留一位小数点
ASR_2019$upper <- round(ASR_2019$upper,1) ###保留一位小数点

####  map for ASR
worldData <- map_data('world')
country_asr <- ASR_2019
country_asr$location <- as.character(country_asr$location) 
###以下代码的目的是让country_asr$location的国家名称与worldData的国家名称一致
### 这样才能让数据映射到地图上
country_asr$location[country_asr$location == 'United States of America'] = 'USA'
country_asr$location[country_asr$location == 'Russian Federation'] = 'Russia'
country_asr$location[country_asr$location == 'United Kingdom'] = 'UK'
country_asr$location[country_asr$location == 'Congo'] = 'Republic of Congo'
country_asr$location[country_asr$location == "Iran (Islamic Republic of)"] = 'Iran'
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = 'North Korea'
country_asr$location[country_asr$location == "Taiwan (Province of China)"] = 'Taiwan'
country_asr$location[country_asr$location == "Republic of Korea"] = 'South Korea'
country_asr$location[country_asr$location == "United Republic of Tanzania"] = 'Tanzania'
country_asr$location[country_asr$location == "C?te d'Ivoire"] = 'Saint Helena'
country_asr$location[country_asr$location == "Bolivia (Plurinational State of)"] = 'Bolivia'
country_asr$location[country_asr$location == "Venezuela (Bolivarian Republic of)"] = 'Venezuela'
country_asr$location[country_asr$location == "Czechia"] = 'Czech Republic'
country_asr$location[country_asr$location == "Republic of Moldova"] = 'Moldova'
country_asr$location[country_asr$location == "Viet Nam"] = 'Vietnam'
country_asr$location[country_asr$location == "Lao People's Democratic Republic"] = 'Laos'
country_asr$location[country_asr$location == "Syrian Arab Republic"] = 'Syria'
country_asr$location[country_asr$location == "North Macedonia"] = 'Macedonia'
country_asr$location[country_asr$location == "Micronesia (Federated States of)"] = 'Micronesia'
country_asr$location[country_asr$location == "Macedonia"] = 'North Macedonia'
country_asr$location[country_asr$location == "Trinidad and Tobago"] = 'Trinidad'
country_asr <- rbind(country_asr,country_asr[country_asr$location == "Trinidad",])
country_asr$location[country_asr$location == "Trinidad"] = 'Tobago'
country_asr$location[country_asr$location == "Cabo Verde"] = 'Cape Verde'
country_asr$location[country_asr$location == "United States Virgin Islands"] = 'Virgin Islands'
country_asr$location[country_asr$location == "Antigua and Barbuda"] = 'Antigu'
country_asr <- rbind(country_asr,country_asr[country_asr$location == "Antigu",])
country_asr$location[country_asr$location == "Antigu"] = 'Barbuda'
country_asr$location[country_asr$location == "Saint Kitts and Nevis"] = 'Saint Kitts'
country_asr <- rbind(country_asr,country_asr[country_asr$location == "Saint Kitts",])
country_asr$location[country_asr$location == "Saint Kitts"] = 'Nevis'
country_asr$location[country_asr$location == "C么te d'Ivoire"] = 'Ivory Coast'
country_asr$location[country_asr$location == "Saint Vincent and the Grenadines"] = 'Saint Vincent'
country_asr <- rbind(country_asr,country_asr[country_asr$location == "Saint Vincent",])
country_asr$location[country_asr$location == "Saint Vincent"] = 'Grenadines'
country_asr$location[country_asr$location == "Eswatini"] = 'Swaziland'
country_asr$location[country_asr$location == "Brunei Darussalam"] = 'Brunei'

worldData <- map_data('world')
total <- full_join(worldData,country_asr,by = c('region'='location'))

p <- ggplot()
total <- total %>% mutate(val2 = cut(val, breaks = c(0,2,5,10,20,100),
                                     labels = c("0~2.0","2.0~5.0","5.0~10.0",
                                                "10.0~20.0","20.0+"),  ### breaks需要根据自己的实际结果来调整
                                     include.lowest = T,right = T))

p2 <- p + geom_polygon(data=total, 
                       aes(x=long, y=lat, group = group,fill=val2),
                       colour="black",size = .2) + 
  scale_fill_brewer(palette = "Reds")+
  theme_void()+labs(x="", y="")+
  guides(fill = guide_legend(title='ASR(/10^5)'))+
  theme(legend.position = 'right')
p2

### case change
####   case change MAP
case_2019 <- subset(EC,EC$year==2019 & 
                     EC$age=='All Ages' & 
                     EC$metric== 'Number' &
                     EC$measure=='Incidence') ## 获取2019年EC发病数
case_1990 <- subset(EC,EC$year==1990 & 
                      EC$age=='All Ages' & 
                      EC$metric== 'Number' &
                      EC$measure=='Incidence') ## 获取1990年EC发病数
case_1990 <- case_1990[,c(2,8)]
case_2019 <- case_2019[,c(2,8)]
names(case_1990) <- c('location','case_1990')
names(case_2019) <- c('location','case_2019')
country_asr <- merge(case_1990, case_2019, by='location')
country_asr$val <- (country_asr$case_2019-country_asr$case_1990)/country_asr$case_1990*100  ### 获取我们的结果

country_asr$location <- as.character(country_asr$location) 
country_asr$location[country_asr$location == 'United States of America'] = 'USA'
country_asr$location[country_asr$location == 'Russian Federation'] = 'Russia'
country_asr$location[country_asr$location == 'United Kingdom'] = 'UK'
country_asr$location[country_asr$location == 'Congo'] = 'Republic of Congo'
country_asr$location[country_asr$location == "Iran (Islamic Republic of)"] = 'Iran'
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = 'North Korea'
country_asr$location[country_asr$location == "Taiwan (Province of China)"] = 'Taiwan'
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = 'North Korea'
country_asr$location[country_asr$location == "Republic of Korea"] = 'South Korea'
country_asr$location[country_asr$location == "United Republic of Tanzania"] = 'Tanzania'
country_asr$location[country_asr$location == "C?te d'Ivoire"] = 'Saint Helena'
country_asr$location[country_asr$location == "Bolivia (Plurinational State of)"] = 'Bolivia'
country_asr$location[country_asr$location == "Venezuela (Bolivarian Republic of)"] = 'Venezuela'
country_asr$location[country_asr$location == "Czechia"] = 'Czech Republic'
country_asr$location[country_asr$location == "Republic of Moldova"] = 'Moldova'
country_asr$location[country_asr$location == "Viet Nam"] = 'Vietnam'
country_asr$location[country_asr$location == "Lao People's Democratic Republic"] = 'Laos'
country_asr$location[country_asr$location == "Lao People's Democratic Republic"] = 'Laos'
country_asr$location[country_asr$location == "Syrian Arab Republic"] = 'Syria'
country_asr$location[country_asr$location == "North Macedonia"] = 'Macedonia'

worldData <- map_data('world')
total <- full_join(worldData,country_asr,by = c('region'='location'))

p <- ggplot()

total <- total %>% mutate(val2 = cut(val, breaks = c(-60,-30,0,50,100,200,300,1200),
                                     labels = c("30% to 60% decrease","<30% decrease","<50% increase",
                                                "50% to 100% increase","100% to 200% increase", 
                                                "200% to 300% increase", ">300% increase"),
                                     include.lowest = T,right = T))

p2 <- p + geom_polygon(data=total, 
                       aes(x=long, y=lat, group = group,fill=val2),
                       colour="black",size = .2) + 
  scale_fill_manual(values = c("#006400", "#66CD00", "#FFE4C4", "#FF7256", "#FF4040", "#CD3333", "#8B2323"))+
  theme_void()+labs(x="", y="")+
  guides(fill = guide_legend(title='Change in cancer cases'))+
  theme(legend.position = 'right')
p2


## map for EAPC
## EAPC
EAPC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Incidence')

EAPC <- EAPC[,c(2,7,8)]

country <- case_2019$location  ###获取国家名称
EAPC_cal <- data.frame(location=country,EAPC=rep(0,times=204),UCI=rep(0,times=204),LCI=rep(0,times=204))
for (i in 1:204){
  country_cal <- as.character(EAPC_cal[i,1])
  a <- subset(EAPC, EAPC$location==country_cal)
  a$y <- log(a$val)
  mod_simp_reg<-lm(y~year,data=a)
  estimate <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1])-1)*100
  low <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]-1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  high <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]+1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  EAPC_cal[i,2] <- estimate
  EAPC_cal[i,4] <- low
  EAPC_cal[i,3] <- high
}
country_asr <- EAPC_cal

country_asr$location <- as.character(country_asr$location) 
country_asr$location[country_asr$location == 'United States of America'] = 'USA'
country_asr$location[country_asr$location == 'Russian Federation'] = 'Russia'
country_asr$location[country_asr$location == 'United Kingdom'] = 'UK'
country_asr$location[country_asr$location == 'Congo'] = 'Republic of Congo'
country_asr$location[country_asr$location == "Iran (Islamic Republic of)"] = 'Iran'
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = 'North Korea'
country_asr$location[country_asr$location == "Taiwan (Province of China)"] = 'Taiwan'
country_asr$location[country_asr$location == "Democratic People's Republic of Korea"] = 'North Korea'
country_asr$location[country_asr$location == "Republic of Korea"] = 'South Korea'
country_asr$location[country_asr$location == "United Republic of Tanzania"] = 'Tanzania'
country_asr$location[country_asr$location == "C?te d'Ivoire"] = 'Saint Helena'
country_asr$location[country_asr$location == "Bolivia (Plurinational State of)"] = 'Bolivia'
country_asr$location[country_asr$location == "Venezuela (Bolivarian Republic of)"] = 'Venezuela'
country_asr$location[country_asr$location == "Czechia"] = 'Czech Republic'
country_asr$location[country_asr$location == "Republic of Moldova"] = 'Moldova'
country_asr$location[country_asr$location == "Viet Nam"] = 'Vietnam'
country_asr$location[country_asr$location == "Lao People's Democratic Republic"] = 'Laos'
country_asr$location[country_asr$location == "Syrian Arab Republic"] = 'Syria'
country_asr$location[country_asr$location == "North Macedonia"] = 'Macedonia'
worldData <- map_data('world')
total <- full_join(worldData,country_asr,by = c('region'='location'))



p <- ggplot()
p1 <- p + geom_polygon(data=total, 
                       aes(x=long, y=lat, group = group,fill=EAPC),
                       colour="black",size = .2) + 
  scale_fill_gradient2(low = "forestgreen",mid = 'white', high = "red",
                       midpoint = 0)+
  theme_void()+labs(x="", y="")+
  guides(fill = guide_colorbar(title='EAPC'))+
  theme(legend.position = 'right') 
p1
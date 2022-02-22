setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(reshape)
library(ggplot2)
library(ggrepel)

EC <- read.csv('EC_region.csv',header = T)  ## 读取我们的数据
order_SDI <- read.csv('order_SDI.csv',header = F)
SDI <- read.csv('GBD_SDI_1990-2019.csv',header = T)

## 用到reshape包，将SDI数据格式从宽数据格式转换为长数据格式
SDI <- melt(SDI,id='Location')
SDI$variable <- as.numeric(gsub('\\X',replacement = '', SDI$variable))
names(SDI) <- c('location','year','SDI')


### 获取EC的1990-2019的标准发病率数据
EC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Incidence')
EC <- EC[,c(2,7,8)]
names(EC)[3] <- 'ASR'

### 合并SDI与ASR数据
EC_ASR_SDI <- merge(EC,SDI,by=c('location','year'))

EC_ASR_SDI$location <- factor(EC_ASR_SDI$location, 
                              levels=order_SDI$V1, 
                              ordered=TRUE) ## location图例按照我们的顺序排列

##开始作图，主变量为ASR以及SDI,图形的颜色和形状根据不同区域来调整即可
### 同时以所有数据画出拟合曲线
ggplot(EC_ASR_SDI, aes(SDI,ASR)) + geom_point(aes(color = location, shape= location))+
  scale_shape_manual(values = 1:22) + 
  geom_smooth(colour='black',stat = "smooth",method='loess',se=F,span=0.5) 


#### figure 4B
EC <- read.csv('EC_nation.csv',header = T)  ## 读取我们的数据
SDI <- read.csv('GBD_SDI_1990-2019.csv',header = T)

## 用到reshape包，将SDI数据格式从宽数据格式转换为长数据格式，
SDI <- melt(SDI,id='Location')
SDI$variable <- as.numeric(gsub('\\X',replacement = '', SDI$variable))
names(SDI) <- c('location','year','SDI')
SDI <- SDI[SDI$year== 2019,] ###只取2019年的数据

### 获取EC的2019的标准发病率数据
EC <- subset(EC, EC$age=='Age-standardized' & 
               EC$metric== 'Rate' &
               EC$measure=='Incidence' &
               EC$year=='2019')
EC <- EC[,c(2,7,8)]
names(EC)[3] <- 'ASR'

### 调整SDI与EC里location命名一致
EC$location[EC$location == "Democratic People's Republic of Korea"] = 'North Korea'
EC$location[EC$location == 'Russian Federation'] = 'Russia'
EC$location[EC$location == 'United Kingdom'] = 'UK'
EC$location[EC$location == "Iran (Islamic Republic of)"] = 'Iran'
EC$location[EC$location == "Taiwan"] = 'Taiwan (Province of China)'
EC$location[EC$location == "Republic of Korea"] = 'South Korea'
EC$location[EC$location == "United Republic of Tanzania"] = 'Tanzania'
EC$location[EC$location == "C么te d'Ivoire"] = 'Saint Helena'
EC$location[EC$location == "Bolivia (Plurinational State of)"] = 'Bolivia'
EC$location[EC$location == "Venezuela (Bolivarian Republic of)"] = 'Venezuela'
EC$location[EC$location == "Czechia"] = 'Czech Republic'
EC$location[EC$location == "Republic of Moldova"] = 'Moldova'
EC$location[EC$location == "Viet Nam"] = 'Vietnam'
EC$location[EC$location == "Lao People's Democratic Republic"] = 'Laos'
EC$location[EC$location == "Syrian Arab Republic"] = 'Syria'
EC$location[EC$location == "North Macedonia"] = 'Macedonia'
EC$location[EC$location == "Brunei Darussalam"] = 'Brunei'
EC$location[EC$location == "Gambia"] = 'The Gambia'
EC$location[EC$location == "United States of America"] = 'USA'
EC$location[EC$location == "Micronesia (Federated States of)"] = 'Federated States of Micronesia'
EC$location[EC$location == "Bahamas"] = 'The Bahamas'
EC$location[EC$location == "United States Virgin Islands"] = 'Virgin Islands'
EC$location[EC$location == "Macedonia"] = 'North Macedonia'
EC$location[EC$location == 'Democratic Republic of the Congo'] = 'DR Congo'
EC$location[EC$location == 'Congo'] = 'Congo (Brazzaville)'
EC$location[EC$location == 'Cabo Verde'] = 'Cape Verde'

###合并两者数据
EC_ASR_SDI_2019 <- merge(EC,SDI,by=c('location','year'))

##作图
ggplot(EC_ASR_SDI_2019, aes(SDI,ASR,label=location)) + 
  geom_point(aes(color = location)) + 
  geom_text_repel(aes(color = location),size=2,fontface= 'bold',max.overlaps = 160) +
  geom_smooth(colour='black',stat = "smooth",method='loess',se=F,span=0.5) +
   theme(legend.position="none")


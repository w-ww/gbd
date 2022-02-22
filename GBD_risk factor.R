setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(dplyr)
library(ggplot2)
library(ggsci)
### Risk factor for BMI
Risk <- read.csv('EC_risk factor.csv',header = T)
order <- read.csv('order.csv',header = F)
order$V1 <- rev(order$V1) ### 读取纵坐标不同区域的排列顺序
Risk_2019 <- subset(Risk, Risk$year==2019 & 
                      Risk$rei=='High body-mass index' &
                      Risk$metric=='Percent')
Risk_2019$val <- round(Risk_2019$val*100,1)
Risk_2019$val2 <- paste0(Risk_2019$val,'%')  
Risk_2019$location <- factor(Risk_2019$location, 
                                  levels=order$V1, 
                                  ordered=TRUE)  ###让纵坐标——地区按照我们的顺序来显示
##作图
p1 <- ggplot(Risk_2019,aes(location,weight = val, fill = measure))+
  geom_bar(color = 'black',width = .7,position = 'dodge',
           size = .3)+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_nejm() +
  theme_classic()+
  coord_flip() + facet_grid(.~rei) + theme_light() +
  geom_text(aes(label=val2, y=val+1.5), ### 这个数值要根据实际作图结果进行调整
            position=position_dodge(0.9), vjust=0,
            size = 2.5) 
p1

###
## All risk factors
## year=2019
Risk_2019 <- subset(Risk, Risk$year==2019 &
                      Risk$metric=='Percent')
Risk_2019$val <- round(Risk_2019$val*100,1)
Risk_2019$val2 <- paste0(Risk_2019$val,'%')
Risk_2019$location <- factor(Risk_2019$location, 
                                  levels=order$V1, 
                                  ordered=TRUE)
Risk_2019$rei <- factor(Risk_2019$rei, 
                        levels= c('Smoking','Alcohol use', 
                                  'Diet low in fruits',
                                  'High body-mass index',
                                  'Chewing tobacco'), 
                        ordered=TRUE)  ## 按自己想要的顺序排好顺序
p1 <- ggplot(Risk_2019,aes(location,weight = val, fill = measure))+
  geom_bar(color = 'black',width = .7,position = 'dodge',
           size = .3)+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_nejm() +
  theme_classic()+
  coord_flip() + facet_grid(.~rei) + theme_light() +
  geom_text(aes(label=val2, y=val+7.5), 
            position=position_dodge(0.9), vjust=0,
            size = 2.5) 
p1

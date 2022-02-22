setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(ggplot2)
library(ggsci)
LC <- read.csv('LC_Percent.csv',header = T)  ## 读取我们的数据
order <- read.csv('order.csv',header = F) 
order$V1 <- rev(order$V1)


case <- subset(LC,LC$year==2019 & 
                 LC$age=='All Ages' & 
                 LC$metric== 'Number' &
                 LC$measure=='Incidence') ## 获取2019年EC年龄校正后发病率

#### 构建空数据集
LC_percent <- data.frame(location=rep(unique(LC$location),each=length(unique(LC$cause))),
                         cause=rep(unique(LC$cause),length(unique(LC$location))),
                         percent=rep(NA,times=length(unique(LC$cause))*length(unique(LC$location))))

a <- unique(LC$location)
b <- unique(LC$cause)
for (i in 1:length(unique(LC$location))){
  location_i <- a[i]
  data <- subset(case,case$location==location_i)[,c(2,5,8)]
  sum <- sum(data$val)
  data$percent <- data$val/sum
  data <- data[,-3]
  for (j in 1:length(unique(LC$cause))) {
    cause_j <- b[j]
    LC_percent[which(LC_percent$location==location_i & LC_percent$cause==cause_j),3] <- data$percent[which(data$cause==cause_j)]
  }
}

LC_2019 <- LC_percent
LC_2019$year <- 2019



####  1990
case <- subset(LC,LC$year==1990 & 
                 LC$age=='All Ages' & 
                 LC$metric== 'Number' &
                 LC$measure=='Incidence') ## 获取2019年EC年龄校正后发病率


LC_percent <- data.frame(location=rep(unique(LC$location),each=length(unique(LC$cause))),
                         cause=rep(unique(LC$cause),length(unique(LC$location))),
                         percent=rep(NA,times=length(unique(LC$cause))*length(unique(LC$location))))

a <- unique(LC$location)
b <- unique(LC$cause)
for (i in 1:length(unique(LC$location))){
  location_i <- a[i]
  data <- subset(case,case$location==location_i)[,c(2,5,8)]
  sum <- sum(data$val)
  data$percent <- data$val/sum
  data <- data[,-3]
  for (j in 1:length(unique(LC$cause))) {
    cause_j <- b[j]
    LC_percent[which(LC_percent$location==location_i & LC_percent$cause==cause_j),3] <- data$percent[which(data$cause==cause_j)]
  }
}

LC_1990 <- LC_percent
LC_1990$year <- 1990

LC_1990_2019 <- rbind(LC_1990,LC_2019)
LC_1990_2019$text <- as.character(round(LC_1990_2019$percent*100,1))  ### 添加标签变量，用于显示在图像中
#### 按照图中的顺序指定变量排列顺序
LC_1990_2019$location <- factor(LC_1990_2019$location, 
                        levels=order$V1, 
                        ordered=TRUE)
LC_1990_2019$cause <- factor(LC_1990_2019$cause, 
                             levels=c("Liver cancer due to hepatitis B",
                                      "Liver cancer due to hepatitis C",
                                      "Liver cancer due to NASH",
                                      "Liver cancer due to alcohol use",
                                      "Liver cancer due to other causes"), 
                             ordered=TRUE)
### 作图
ggplot(data = LC_1990_2019, aes(x = location, y= percent,fill =cause))+
  geom_bar(stat = 'identity',position = 'fill')+labs(x = '') + 
  scale_fill_lancet() + theme_classic()+
  coord_flip() + facet_grid(.~year) + theme_light() +
  geom_text(aes(label=text, y=percent), ### 这个数值要根据实际作图结果进行调整
            position=position_stack(.5), vjust=0.3,
            size = 2.5) 


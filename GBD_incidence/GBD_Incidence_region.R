setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(dplyr)                            ## 读取需要的R包
library(ggplot2)
EC <- read.csv('EC_region.csv',header = T)  ## 读取我们的数据
order <- read.csv('order.csv',header = F)
EC$location <- factor(EC$location, 
                             levels=order$V1, 
                             ordered=TRUE)



## 1990发病人数
EC_1990 <- subset(EC,EC$year==1990 & 
                    EC$age=='All Ages' & 
                    EC$metric== 'Number' &
                    EC$measure=='Incidence')

EC_1990 <- EC_1990[,c(2,8,9,10)]  ### 只取需要的变量：地区以及对应的数值
EC_1990$val <- round(EC_1990$val,1)  ###取整
EC_1990$lower <- round(EC_1990$lower,1)###取整
EC_1990$upper <- round(EC_1990$upper,1) ###取整
EC_1990$Num_1990 <- paste(EC_1990$lower,EC_1990$upper,sep = '-') ## 用-连接95%UI上下数值
EC_1990$Num_1990 <- paste(EC_1990$Num_1990,')',sep = '')  ##95%UI前后加括号             
EC_1990$Num_1990 <- paste('(',EC_1990$Num_1990,sep = '')  ##95%UI前后加括号
EC_1990$Num_1990 <- paste(EC_1990$val,EC_1990$Num_1990,sep = ' ') ##数据和95%UI用空格键连接

## 2019发病人数
EC_2019 <- subset(EC,EC$year==2019 & 
                    EC$age=='All Ages' & 
                    EC$metric== 'Number' &
                    EC$measure=='Incidence')

EC_2019 <- EC_2019[,c(2,8,9,10)]  ### 只取需要的变量：地区以及对应的数值
EC_2019$val <- round(EC_2019$val,1)  ###取整
EC_2019$lower <- round(EC_2019$lower,1)###取整
EC_2019$upper <- round(EC_2019$upper,1) ###取整
EC_2019$Num_2019 <- paste(EC_2019$lower,EC_2019$upper,sep = '-') ## 用-连接95%UI上下数值
EC_2019$Num_2019 <- paste(EC_2019$Num_2019,')',sep = '')  ##95%UI前后加括号             
EC_2019$Num_2019 <- paste('(',EC_2019$Num_2019,sep = '')  ##95%UI前后加括号
EC_2019$Num_2019 <- paste(EC_2019$val,EC_2019$Num_2019,sep = ' ') ##数据和95%UI用空格键连接


## 1990 ASR
ASR_1990 <- subset(EC,EC$year==1990 & 
                    EC$age=='Age-standardized' & 
                    EC$metric== 'Rate' &
                    EC$measure=='Incidence')

ASR_1990 <- ASR_1990[,c(2,8,9,10)]  ### 只取需要的变量：地区以及对应的数值
ASR_1990$val <- round(ASR_1990$val,1)  ###取整
ASR_1990$lower <- round(ASR_1990$lower,1)###取整
ASR_1990$upper <- round(ASR_1990$upper,1) ###取整
ASR_1990$ASR_1990 <- paste(ASR_1990$lower,ASR_1990$upper,sep = '-') ## 用-连接95%UI上下数值
ASR_1990$ASR_1990 <- paste(ASR_1990$ASR_1990,')',sep = '')  ##95%UI前后加括号             
ASR_1990$ASR_1990 <- paste('(',ASR_1990$ASR_1990,sep = '')  ##95%UI前后加括号
ASR_1990$ASR_1990 <- paste(ASR_1990$val,ASR_1990$ASR_1990,sep = ' ') ##数据和95%UI用空格键连接


## 2019 ASR
ASR_2019 <- subset(EC,EC$year==2019 & 
                     EC$age=='Age-standardized' & 
                     EC$metric== 'Rate' &
                     EC$measure=='Incidence')

ASR_2019 <- ASR_2019[,c(2,8,9,10)]  ### 只取需要的变量：地区以及对应的数值
ASR_2019$val <- round(ASR_2019$val,1)  ###取整
ASR_2019$lower <- round(ASR_2019$lower,1)###取整
ASR_2019$upper <- round(ASR_2019$upper,1) ###取整
ASR_2019$ASR_2019 <- paste(ASR_2019$lower,ASR_2019$upper,sep = '-') ## 用-连接95%UI上下数值
ASR_2019$ASR_2019 <- paste(ASR_2019$ASR_2019,')',sep = '')  ##95%UI前后加括号             
ASR_2019$ASR_2019 <- paste('(',ASR_2019$ASR_2019,sep = '')  ##95%UI前后加括号
ASR_2019$ASR_2019 <- paste(ASR_2019$val,ASR_2019$ASR_2019,sep = ' ') ##数据和95%UI用空格键连接

EC_incidence <- subset(EC, EC$age_name=='Age-standardized' & 
                         EC$metric_name== 'Rate' &
                         EC$measure_name=='Incidence')

##### EAPC
EAPC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Incidence')
EAPC <- EAPC[,c(2,7,8)] ##获取地区、年份以及对应的数值



country <- EC_1990$location
EAPC_cal <- data.frame(location=country,EAPC=rep(0,times=22),UCI=rep(0,times=22),LCI=rep(0,times=22)) 
for (i in 1:22){  ###总共22个地区，所以循环22次
  country_cal <- as.character(EAPC_cal[i,1]) ### 依次取对应的地区
  a <- subset(EAPC, EAPC$location==country_cal)  ##取对应地区的数据子集
  a$y <- log(a$val)  ##根据EAPC计算方法计算y值
  mod_simp_reg<-lm(y~year,data=a) ##根据EAPC计算方法做线性回归方程
  estimate <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1])-1)*100 ##根据EAPC计算方法取方程beta值来计算EAPC
  low <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]-1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  ### 计算EAPC的95%可信区间的上限值
  high <- (exp(summary(mod_simp_reg)[["coefficients"]][2,1]+1.96*summary(mod_simp_reg)[["coefficients"]][2,2])-1)*100
  ### 计算EAPC的95%可信区间的下限值
  EAPC_cal[i,2] <- estimate
  EAPC_cal[i,4] <- low
  EAPC_cal[i,3] <- high
}

EAPC_cal$EAPC <- round(EAPC_cal$EAPC,2)  ##保留2位小数点
EAPC_cal$UCI <- round(EAPC_cal$UCI,2)
EAPC_cal$LCI <- round(EAPC_cal$LCI,2)
EAPC_cal$EAPC_CI <- paste(EAPC_cal$LCI,EAPC_cal$UCI,sep = '-') 
EAPC_cal$EAPC_CI <- paste(EAPC_cal$EAPC_CI,')',sep = '') 
EAPC_cal$EAPC_CI <- paste('(',EAPC_cal$EAPC_CI,sep = '') 
EAPC_cal$EAPC_CI <- paste(EAPC_cal$EAPC,EAPC_cal$EAPC_CI,sep = ' ')  

### 数据整合
EC_1990 <- EC_1990[,c(1,5)]  ###取地区和整合好的变量
ASR_1990 <- ASR_1990[,c(1,5)]
EC_2019 <- EC_2019[,c(1,5)]
ASR_2019 <- ASR_2019[,c(1,5)]
EAPC_cal <- EAPC_cal[,c(1,5)]
Incidence <- merge(EC_1990,ASR_1990,by='location')
Incidence <- merge(Incidence,EC_2019,by='location')
Incidence <- merge(Incidence,ASR_2019,by='location')
Incidence <- merge(Incidence,EAPC_cal,by='location')
write.csv(Incidence,'Results for incidence.csv')

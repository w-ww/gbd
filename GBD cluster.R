setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(dplyr)
library(ggplot2)
library(ggsci)
library(factoextra)
EC <- read.csv('EC_nation.csv',header = T)  ## 读取我们的数据

cluster <- read.csv('Cluster.csv',header = T,row.names = 1)
df <- scale(cluster)

### 计算发病率的EAPC数据
EAPC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Incidence')

EAPC <- EAPC[,c(2,7,8)]

country_name <- subset(EC,EC$year==1990 & 
                      EC$age=='Age-standardized' & 
                      EC$metric== 'Rate' &
                      EC$measure=='Incidence') ###获取国家名称
country <- country_name$location  ###获取国家名称
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
EAPC_incidence <- EAPC_cal[,c(1,2)]
names(EAPC_incidence)[2] <- 'EAPC_incidence'

### 计算死亡率的EAPC数据
EAPC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Deaths')

EAPC <- EAPC[,c(2,7,8)]

country_name <- subset(EC,EC$year==1990 & 
                         EC$age=='Age-standardized' & 
                         EC$metric== 'Rate' &
                         EC$measure=='Deaths') ###获取国家名称
country <- country_name$location  ###获取国家名称
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
EAPC_Deaths <- EAPC_cal[,c(1,2)]
names(EAPC_Deaths)[2] <- 'EAPC_Deaths'
###合并三者数据成一个数据集
cluster <- merge(EAPC_incidence,EAPC_Deaths, by='location')
data <- cluster
rownames(data) <- data[,1]
data <- data[,-1]
## 画聚类图形
df <- scale(data)
# Hierarchical clustering
res.hc <- hclust(dist(df,method="euclidean"),method = "complete")
###画图
fviz_dend(res.hc, cex = 0.5, k = 4, color_labels_by_k = TRUE,
          k_colors=c('#3399FF','lightblue','red','#FFCC66'),
          horiz = T, rect = TRUE)
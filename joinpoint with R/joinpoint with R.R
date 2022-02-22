### 安装需要用到的软件包
devtools::install_github("Miachol/configr")
#### for joinpoint
setwd('E:/clinical data mining/Xiaoming/GBD') ##设置工作路径
library(dplyr)                               ##读取需要的R包
library(ggplot2)
library(configr)
EC <- read.csv('EC_nation.csv',header = T)  ##读取我们的数据
EAPC <- subset(EC, EC$age=='Age-standardized' & 
                 EC$metric== 'Rate' &
                 EC$measure=='Incidence')

EAPC$SE <- (EAPC$upper-EAPC$lower)/(1.96*2)   ##根据95%UI 计算标准误
EAPC <- EAPC[,c(2,7,8,11)] ##获取地区、年份以及对应的数值
EAPC <- EAPC[order(EAPC$location,EAPC$year),]   ### joinpoint要求年份按照升序排列，且一个组放在一起
write.csv(EAPC,'joinpoint.csv',row.names = F,col.names = F)

#### 针对配置文件，小改的话可以运行如下代码进行修改，比如我们需要修改输入文件，我们可以直接在R中进行
####读取配置文件
library(configr)
GBD_Created_Session <- read.config('GBD.Created.Session.ini')
GBD_JPOptions <- read.config('GBD.JPOptions.ini')
##修改配置文件
GBD_Created_Session[["Datafile options"]][["Datafile name"]] <- 'E:/clinical data mining/Xiaoming/GBD/joinpoint.csv'

###修改完毕后替代原来的文件
write.config(config.dat = GBD_Created_Session, file.path = sprintf("%s/GBD.Created.Session.ini", getwd()), write.type = "ini")
write.config(config.dat = GBD_JPOptions, file.path = sprintf("%s/GBD.JPOptions.ini", getwd()), write.type = "ini")


### 软件调用
# Create an input file for the Joinpoint program(软件运行配置文件)
filedir <- paste0(getwd(),'/')
jprun.ini.file =  "GBD.JPRun.ini"
cat(file = jprun.ini.file, "[Joinpoint Input Files]\n", append = FALSE)
cat(file = jprun.ini.file, paste0("Session File=", filedir, "GBD.Created.Session.ini\n"), append = TRUE)
cat(file = jprun.ini.file, paste0("Output File=", filedir, "GBD", ".jpo\n"), append = TRUE)
cat(file = jprun.ini.file, paste0("Export Options File=", filedir, "GBD.JPOptions.ini\n"), append = TRUE)
cat(file = jprun.ini.file, paste0("Run Options File=", filedir, "GBD.JPOptions.ini"), append = TRUE)


system(paste("jpCommand.exe", jprun.ini.file))

AAPC <- read.table('GBD.aapcexport.txt', header= TRUE)
AAPC <- AAPC[,c(1,6:8)]
names(AAPC)[2:4] <- c('val','lower','upper')

AAPC$AAPC <- paste(AAPC$lower,AAPC$upper,sep = ' - ') ## 用"-"连接95%UI上下数值
AAPC$AAPC <- paste(AAPC$AAPC,')',sep = '')  ##95%UI前后加括号             
AAPC$AAPC <- paste('(',AAPC$AAPC,sep = '')  ##95%UI前后加括号
AAPC$AAPC <- paste(AAPC$val,AAPC$AAPC,sep = ' ') ##数据和95%UI用空格键连接



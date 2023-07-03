
# 导入所用到的R包
library(ggplot2)
library(plyr)
library(dplyr)
library(magrittr)
library(tidyr)

# 首先修改数据集的编码格式为'utf-8'，防止读取数据集错误
# 每一个数据集中19年12月的数据是缺失的，这里用20年3月的数据代替19年12月的数据

# 修改工作路径，方便读入数据
setwd('C:/Users/OneRaise/Desktop/R/R语言2023年实验报告数据')

################################################################################
# 2.1 

# 读入数据并处理
net_num <- read.csv('(1)2002-2022年网民数量.csv')
# 将时间在转换成因子类型，保证画出来的图排序正确
net_num$时间 <- factor(net_num$时间,levels = rev(c(net_num$时间)))

# (1)
net_num1 <- net_num$网民数量.万人.
growth_rate <- (net_num1[-c(42)]-net_num1[-c(1)])/net_num1[-c(1)]
growth_rate[42] <- NA

# 输出结果
time <- net_num$时间
result1 <- data.frame(time,growth_rate)
head(result1,10)

# (2)
ggplot(net_num,aes(x = 时间)) + 
  geom_bar(aes(y = 网民数量.万人.),stat = 'identity',fill = '#7B9CE1') +
  geom_point(aes(y = rescale(result1$growth_rate,c(0,100000))),
             stat = 'identity',size = 1) +
  geom_line(aes(y = rescale(result1$growth_rate,c(0,100000)),group = 1),
            stat = 'identity') +
  scale_y_continuous(
    sec.axis = sec_axis(~rescale(.,c(0,0.31)),name = '网民数量增长率')
  )+
  labs(title = '网民数量、网民数量增长率双轴图')

################################################################################
# 2.2

# 读入数据
net_access <- read.csv('(2)2007-2022年接入方式.csv')
result2 <- data.frame(time)

# (1)	与“(1)2002-2022年网民数量.csv”进行合并
num_access <- full_join(net_num,net_access,by = c('时间' = '时间'))

# (2)	
# 数据类型转化函数
trans_num <- function(percentage){
  percentage <- gsub("%","",percentage)
  percentage <- as.numeric(percentage)
  percentage <- percentage/100
  return(percentage)
}
# 将比例的字符串类型改为数值型
result2$tv_rate <- trans_num(num_access$电视上网比例)
result2$desk_rate <- trans_num(num_access$台式电脑上网比例)
result2$lap_rate <- trans_num(num_access$笔记本电脑上网比例)
result2$pad_rate <- trans_num(num_access$平板电脑上网比例)

# 计算各项目人数的函数
num_calculate <- function(percentage){
  num <- num_access$网民数量.万人.*percentage
  return(num)
}
# 手机上网比例
result2$mobile_rate <- num_access$手机网民数量.万人./num_access$网民数量.万人.
# 电视网民数
result2$tv_num <- num_calculate(result2$tv_rate)
# 台式电脑网民数
result2$desk_num <- num_calculate(result2$desk_rate)
# 笔记本电脑网民数
result2$lap_num <- num_calculate(result2$lap_rate)
# 平板电脑网民数
result2$pad_num <- num_calculate(result2$pad_rate)
# 结果展示
head(result2,10)

# (3)
# 将时间在转换成因子类型，保证画出来的图排序正确
num_access$时间 <- factor(num_access$时间,levels = rev(c(num_access$时间)))
# 画图
ggplot(num_access,aes(x=时间)) +
  geom_line(aes(y = result2$mobile_rate),
            stat = 'identity',group = 1,color = 'blue') + 
  geom_point(aes(y = result2$mobile_rate),
             stat = 'identity',color = 'blue') +
  geom_line(aes(y = result2$tv_rate),
            stat = 'identity',group = 2,color = 'red') + 
  geom_point(aes(y = result2$tv_rate),
             stat = 'identity',color = 'red') +
  geom_line(aes(y = result2$desk_rate),
            stat = 'identity',group = 3,color = 'green') + 
  geom_point(aes(y = result2$desk_rate),
             stat = 'identity',color = 'green') +
  geom_line(aes(y = result2$lap_rate),
            stat = 'identity',group = 4,color = 'yellow') + 
  geom_point(aes(y = result2$lap_rate),
             stat = 'identity',color = 'yellow') +
  geom_line(aes(y = result2$pad_rate),
            stat = 'identity',group = 5,color = 'purple') + 
  geom_point(aes(y = result2$pad_rate),
             stat = 'identity',color = 'purple') +
  scale_colour_manual(name='Species',values = c('blue')) +
  theme(text = element_text(family = "STXihei"),
        legend.position = c(.075,.915),
        legend.box.background = element_rect(color="black")
        ) +
  theme_bw()


################################################################################
# 2.3 

# 读入数据集：“(3)2008-2022年网民结构.csv”
net_structure <- read.csv('(3)2008-2022年网民结构.csv')
time <- net_structure$时间
result3 <- data.frame(time)

# (1)	与“(1)2002-2022年网民数量.csv”进行合并；
num_sructure <- right_join(net_num,net_structure,by = c('时间' = '时间'))

# (2)	

# 计算人数的函数
calculate_num <- function(percentage){
  percentage <- gsub("%","",percentage)
  percentage <- as.numeric(percentage)
  percentage <- percentage/100
  num <- num_sructure$网民数量.万人.*percentage
  return(num)
}
items <- c('town','rural','male','female','age0-9','age10-19','age20-29',
           'age30-39','age40-49','age50-59','age60-','primary','junior',
           'middle','junior college','bachelor degree')
# 循环
for (i in 4:ncol(num_sructure)){
  result3[items[i-3]] <- calculate_num(num_sructure[[i]])
}

# (3)	

# 计算比例的函数
calculate_ratio <- function(num1,num2){
  ratio <- num2/num1*100
  return(ratio)
}

# 计算网民数量和学历
result3$'age0-19' <- result3$`age0-9` + result3$`age10-19`
result3$'age19-' <- result3$`age20-29` + result3$`age30-39` +
  result3$`age40-49`+ result3$`age50-59` + result3$`age60-`
result3$'under junior' <- result3$primary + result3$junior
result3$'above junior' <- result3$middle + result3$`junior college` +
  result3$`bachelor degree`

# 计算比例
result3$'gender ratio' <- calculate_ratio(result3$female,result3$male)
result3$'town-rural ratio' <- calculate_ratio(result3$rural,result3$town)
result3$'age ratio' <- calculate_ratio(result3$`age0-19`,result3$`age19-`)
result3$'edu ratio' <- calculate_ratio(result3$`under junior`,
                                       result3$`above junior`)

# 显示结果
head(result3,10)

# (4)	

# 将时间在转换成因子类型，保证画出来的图排序正确
result3$time <- factor(result3$time,levels = rev(c(result3$time)))
town_rural <- gather(result3,key="variable",value = "value",town,rural)
# 保留两位小数
town_rural$`town-rural ratio`<-round(town_rural$`town-rural ratio`,2)

# 绘图
ggplot(town_rural,aes(x = time,y = value,fill = variable)) +
  geom_bar(stat = "identity",position = "dodge")+
  scale_fill_manual(values = c("#7B9CE1","#90969C"))+
  geom_line(aes(y = rescale(town_rural$`town-rural ratio`,c(0,60000))),
            stat = 'identity',group = 1,color = 'black') + 
  geom_point(aes(y = rescale(town_rural$`town-rural ratio`,c(0,60000))),
          stat = 'identity',color = 'red') + 
  geom_text(aes(y = rescale(town_rural$`town-rural ratio`,c(0,60000)),
                label = town_rural$`town-rural ratio`,),vjust = -1) +
  scale_y_continuous(
    name = '人口总数',
    sec.axis = sec_axis(~rescale(.,c(0,301)),name = '城乡比')
  )+
  labs(title = '城镇和农村网民数量及城乡比') + 
  # 修改图例的位置
  theme(legend.position = c(0,0),
        legend.justification = c(1, 0),
  ) +
  theme_bw()

################################################################################

# 2.4 读入数据集：“(4)2007-2022年各应用网民数.csv”（删除前面的说明部分）
net_app <- read.csv('(4)2007-2022年各应用网民数.csv')

# (1)	
net_app$网上外卖[is.na(net_app$网上外卖)] <- mean(net_app$网上外卖,na.rm = T)
net_app$在线旅游预订[is.na(net_app$在线旅游预订)] <- mean(net_app$在线旅游预订,
                                              na.rm=T)
net_app[is.na(net_app)] <- 0
result4 <- data.frame(time = net_app$时间)

# (2)
# 分类
result4$基础应用类<-rowSums(net_app[,c(2,6,16,13)])
result4$商务交易类<-rowSums(net_app[,c(4,5,10,14,17)])
result4$网络娱乐类<-rowSums(net_app[,c(3,8,7,11,9)])
result4$公开服务类<-rowSums(net_app[,c(12,15,18)])

# 计算增长率
app1_num <- result4$基础应用类
app1_rate <- (app1_num[-c(31)]-app1_num[-c(1)])/app1_num[-c(1)]
app1_rate[31] <- NA
result4$app1_rate <- app1_rate

app2_num <- result4$商务交易类
app2_rate <- (app2_num[-c(31)]-app2_num[-c(1)])/app2_num[-c(1)]
app2_rate[31] <- NA
result4$app2_rate <- app2_rate

app3_num <- result4$网络娱乐类
app3_rate <- (app3_num[-c(31)]-app3_num[-c(1)])/app3_num[-c(1)]
app3_rate[31] <- NA
result4$app3_rate <- app3_rate

app4_num <- result4$公开服务类
app4_rate <- (app4_num[-c(31)]-app4_num[-c(1)])/app4_num[-c(1)]
app4_rate[31] <- NA
result4$app4_rate <- app4_rate

# 将时间在转换成因子类型，保证画出来的图排序正确
result4$time <- factor(result4$time,levels = rev(c(result4$time)))

result4_1 <- data.frame(a = c('基础应用类','商务交易类',
                              '网络娱乐类','公开服务类'),
                        b = c(8.3473257,10.019240,2.7119126,-7.518586))
# 绘制2020年半年增长雷达图
ggplot(result4_1,aes(x = a))+
  geom_polygon(aes(y = b,group=1),fill="#7B9CE1",alpha=0.5)+
  geom_line(aes(y = b,group=1))+
  coord_polar(start = -pi/2)+
  theme_minimal()+
  labs(title = "2020年12月半年增长率雷达图")

# (3)	
# 计算增长率
# 网约车
app_car_num <- net_app$网约车
app_car_rate <- 
  (net_app$网约车[-c(31)]-net_app$网约车[-c(1)])/net_app$网约车[-c(1)]
app_car_rate[31] <- NA
result4$app_car_rate <- app_car_rate

# 在线医疗
app_med_num <- net_app$在线医疗
app_med_rate <- 
  (net_app$在线医疗[-c(31)]-net_app$在线医疗[-c(1)])/net_app$在线医疗[-c(1)]
app_med_rate[31] <- NA
result4$app_med_rate <- app_med_rate

# 在线教育
app_edu_num <- net_app$在线教育
app_edu_rate <- 
  (net_app$在线教育[-c(31)]-net_app$在线教育[-c(1)])/net_app$在线教育[-c(1)]
app_edu_rate[31] <- NA
result4$app_edu_rate <- app_edu_rate

# 开头的在线教育的值的整理
result4[[3,12]] <- 0

# 画图
ggplot(result4,aes(x= time)) +
  geom_line(aes(y = result4$app_car_rate),
            stat = 'identity',group = 1,color = 'blue') + 
  geom_point(aes(y = result4$app_car_rate),
             stat = 'identity',color = 'blue') +
  geom_line(aes(y = result4$app_med_rate),
            stat = 'identity',group = 2,color = 'red') + 
  geom_point(aes(y = result4$app_med_rate),
             stat = 'identity',color = 'red') +
  geom_line(aes(y = result4$app_edu_rate),
            stat = 'identity',group = 3,color = 'green') + 
  geom_point(aes(y = result4$app_edu_rate),
             stat = 'identity',color = 'green') +
  scale_y_continuous(name = '增长率')+
  labs(title = '城镇和农村网民数量及城乡比') + 
  theme_bw()
# 
#规范化指标数据，规范化后的指标形成新的字段
result4$app_car_rate_sc <- scale(result4$app_car_rate)
result4$app_med_rate_sc <- scale(result4$app_med_rate)
result4$app_edu_sc <- scale(result4$app_edu_rate)
# 生成自增序列，用于后面一元线性回归
result4$id<-1:nrow(result4)
# 整理生成的增长率
result4[is.na(result4)] <- 0
result4[[15,9]] <- 0
result4[[13,10]] <- 0
result4[[6,11]] <- 0
result4[[15,12]] <- 0
# 建立一元线性回归模型
lm_ind1<-lm(result4$app_car_rate ~ result4$id)
lm_ind2<-lm(result4$app_med_rate ~ result4$id)
lm_ind3<-lm(result4$app_edu_rate ~ result4$id)
# 画出拟合图
plot(result4$app_car_rate,type='l')
lines(fitted(lm_ind1),col='blue')
plot(result4$app_med_rate,type='l')
lines(fitted(lm_ind2),col='blue')
plot(result4$app_edu_rate,type='l')
lines(fitted(lm_ind3),col='blue')

# 显示结果
head(result4,10)

################################################################################

# 2.5 

# 数据合并
result5 <- merge(result1,
                 result2[c('time','lap_rate','mobile_rate')],by = 'time')
result5 <- merge(result5,result3[c('gender ratio','town-rural ratio',
                           'age ratio','edu ratio','time')],by = 'time')
result5 <- merge(result5,
                 result4[c('基础应用类','商务交易类','网络娱乐类',
                           '公开服务类','time')],by = 'time')

# (1)	按照二级指标的分类，给每一部分设置判断矩阵；
num_matrix <- matrix(c(1,2,1/2,1),
                     nrow = 2,
                     byrow = T,
                     dimnames = list(c('网民数量','网民数量增长率'),
                                     c('网民数量','网民数量增长率')))
access_matrix <- matrix(c(1,2,1/2,1),
                        nrow = 2,
                        byrow = T,
                        dimnames = list(c('手机接入比例','笔记本电脑接入比例'),
                                        c('手机接入比例','笔记本电脑接入比例')))

structure_matrix <- matrix(c(1,2,3,5,1/2,1,2,3,1/3,1/2,1,2,1/5,1/3,1/2,1),
                        nrow = 4,
                        byrow = T,
                        dimnames = list(c('性别比','城乡比','年龄比','学历比'),
                                        c('性别比','城乡比','年龄比','学历比')))
app_matrix <- matrix(c(1,2,3,5,1/2,1,2,3,1/3,1/2,1,2,1/5,1/3,1/2,1),
                           nrow = 4,
                           byrow = T,
                           dimnames = list(c('基础应用类网民数量','商务交易类网民数量',
                                             '网络娱乐类网民数量','公共服务类网民数量'),
                                           c('基础应用类网民数量','商务交易类网民数量',
                                             '网络娱乐类网民数量','公共服务类网民数量')))
devvelop_matrix <- matrix(c(1,2,4,7,1/2,1,2,3,1/4,1/2,1,2,1/7,1/3,1/2,1),
                          nrow = 4,
                          byrow = T,
                          dimnames = list(c('网民规模','接入方式','网民结构','应用状况'),
                                          c('网民规模','接入方式','网民结构','应用状况')))
# (2)	
consistency_check<-function(judgematrix){
  n<-ncol(judgematrix)
  # 求最大特征根和特征向量
  rowprod<-apply(judgematrix,1,prod)
  rowprod_sqrt<-rowprod^(1/n)
  # 特征向量
  weight<-rowprod_sqrt/sum(rowprod_sqrt)  
  aw<-judgematrix%*%weight
  # 最大特征值
  lamda_max<-sum(aw/(weight*n))  
  # 计算一致性
  ri <- c(0, 0, 0.58, 0.9, 1.12, 1.24, 1.32, 1.41, 1.45, 1.49, 1.51)
  ci <- (lamda_max - n)/(n - 1)
  cr <- round(ci/ri[n],4)
  if(cr>=0.1){
    consistency<-"一致性检验不通过，请调整判断矩阵"
  } else {consistency<-"判断矩阵符合一致性要求"}
  crresult<-matrix(c(0,0),nrow=1)
  colnames(crresult)<-c("cr","是否一致性")
  crresult[1,1]<-cr
  crresult[1,2]<-consistency
  # 输出结果
  result<-list(weight=weight,consistency=crresult)
  return(result)
}

# (3)	
# 查看结果得出权重
consistency_check(num_matrix)
consistency_check(access_matrix)
consistency_check(structure_matrix)
consistency_check(app_matrix)
consistency_check(devvelop_matrix)

# 显示结果
head(result5,10)

################################################################################

# 2.6 
# 编写函数读入数据
data_read <- function(data_path,year){
  net_scale <- read.csv(data_path)
  net_scale$year <- year
  return(net_scale)
}

data_paths <- paste0('各省历年网民规模/',2007:2016,'年网民规模.csv')
net_scale <- data.frame()

for (i in 1:10){
  year <- 2007:2016
  net_scale <- rbind(net_scale,data_read(data_paths[i],year[i]))
}
result6 <- net_scale

# (1)	根据数据中各省历年网民规模和互联网普及率，大概计算各省历年人口数；

# 将普及率转换成数值型
result6$互联网普及率 <- trans_num(result6$互联网普及率)
# 计算人口数
result6$population <- result6$网民数.万人./result6$互联网普及率

# (2)	
GDP <- read.csv('GDP.csv')
result6 <- right_join(result6,GDP,by = c('省份' = '省份','year' = 'year'))

# 显示结果
head(result6,10)

# (3)	
# 计算人均GDP
result6$average_GDP <- result6$GDP/result6$population
lm_GDP <- lm(result6$互联网普及率~result6$average_GDP)
summary(lm_GDP)

# 统计显著性检验显示，人均GDP的系数估计值在95%的置信水平下是显著的（p-value < 0.001），说明人均GDP对互联网普及率的影响是具有统计学意义的。
# 调整后的决定系数为0.7474，说明回归模型可以解释约74.74%的互联网普及率的变异。
# 综上所述，根据该线性回归分析，人均GDP对互联网普及率具有正向影响，即随着人均GDP的增加，互联网普及率也有所增加。

# 

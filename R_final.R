# 导入所用到的R包
library(ggplot2)
library(plyr)
library(dplyr)
library(magrittr)
# 首先修改数据集的编码格式为'utf-8'，防止读取数据集错误
# 修改工作路径，方便读入数据
setwd('C:/Users/OneRaise/Desktop/R/R语言2023年实验报告数据')

#########################################################
# 2.1 

# 读入数据并处理
netizens_num <- read.csv('(1)2002-2022年网民数量.csv')
# 将时间在转换成因子类型，保证画出来的图排序正确
netizens_num$时间 <- factor(netizens_num$时间,levels = rev(c(netizens_num$时间)))

# (1)
net_num <- netizens_num$网民数量.万人.
growth_rate <- (net_num[-c(42)]-net_num[-c(1)])/net_num[-c(1)]
growth_rate[42] <- NA
netizens_num$growth_rate <- growth_rate
# (2)
ggplot(netizens_num,aes(x = 时间)) + 
  geom_bar(aes(y = 网民数量.万人.),stat = 'identity',fill = '#7B9CE1') +
  geom_point(aes(y = rescale(growth_rate,c(0,100000))),stat = 'identity',size = 1) +
  geom_line(aes(y = rescale(growth_rate,c(0,100000)),group = 1),stat = 'identity') +
  scale_y_continuous(
    sec.axis = sec_axis(~rescale(.,c(0,0.31)),name = '网民数量增长率')
  )+
  labs(title = '网民数量、网民数量增长率双轴图')

# (3)
# 总体上看，我国网民数量呈增长趋势
# 增速在2002年到2008年达到高峰，接着增速整体上逐年递减

#########################################################
# 2.2

# 读入数据
net_access <- read.csv('(2)2007-2022年接入方式.csv')

# (1)	与“(1)2002-2022年网民数量.csv”进行合并
num_access <- full_join(netizens_num,net_access,by = c('时间' = '时间'))

# (2)	计算出手机上网比例、电视网民数、台式电脑网民数、笔记本电脑网民数、平板电脑网民数（不同接入方式人数有重合，总数会大于真实网民数量）
# 数据类型转化函数
trans_num <- function(percentage){
  percentage <- gsub("%","",percentage)
  percentage <- as.numeric(percentage)
  percentage <- percentage/100
  return(percentage)
}
# 将比例的字符串类型改为数值型
num_access$电视上网比例 <- trans_num(num_access$电视上网比例)
num_access$台式电脑上网比例 <- trans_num(num_access$台式电脑上网比例)
num_access$笔记本电脑上网比例 <- trans_num(num_access$台式电脑上网比例)
num_access$平板电脑上网比例 <- trans_num(num_access$平板电脑上网比例)
# 计算各项目人数的函数
num_calculate <- function(percentage){
  num <- num_access$网民数量.万人.*percentage
  return(num)
}
# 手机上网比例
num_access$mobile_access_rate <- num_access$手机网民数量.万人./num_access$网民数量.万人.
# 电视网民数
num_access$tv_netizens_num <- num_calculate(num_access$电视上网比例)
# 台式电脑网民数
num_access$desk_netizens_num <- num_calculate(num_access$台式电脑上网比例)
# 笔记本电脑网民数
num_access$lap_netizens_num <- num_calculate(num_access$笔记本电脑上网比例)
# 平板电脑网民数
num_access$pad_netizens_num <- num_calculate(num_access$平板电脑上网比例)

# (3)	根据数据绘制各种接入方式比例的折线图，并比较说明每种接入方式的变化趋势与特征。
# 将时间在转换成因子类型，保证画出来的图排序正确
num_access$时间 <- factor(num_access$时间,levels = rev(c(num_access$时间)))

# 画图
ggplot(num_access,aes(x=时间)) +
  geom_line(aes(y = mobile_access_rate),stat = 'identity',group = 1,color = 'blue') + 
  geom_point(aes(y = mobile_access_rate),stat = 'identity',color = 'blue') +
  geom_line(aes(y = 电视上网比例),stat = 'identity',group = 2,color = 'red') + 
  geom_point(aes(y = 电视上网比例),stat = 'identity',color = 'red') +
  geom_line(aes(y = 台式电脑上网比例),stat = 'identity',group = 3,color = 'green') + 
  geom_point(aes(y = 台式电脑上网比例),stat = 'identity',color = 'green') +
  geom_line(aes(y = 笔记本电脑上网比例),stat = 'identity',group = 4,color = 'yellow') + 
  geom_point(aes(y = 笔记本电脑上网比例),stat = 'identity',color = 'yellow') +
  geom_line(aes(y = 平板电脑上网比例),stat = 'identity',group = 5,color = 'purple') + 
  geom_point(aes(y = 平板电脑上网比例),stat = 'identity',color = 'purple') +
  scale_colour_manual(name='Species',values = c('blue')) +
  theme(text = element_text(family = "STXihei"),#设置中文字体的显示
        legend.position = c(.075,.915),#更改图例的位置，放至图内部的左上角
        legend.box.background = element_rect(color="black")#为图例添加边框线
        ) +
  theme_bw()
# 由折线图可以看出，手机上网比例整体上逐年上升，到2012年年底成为上网比例最高的接
# 入方式；电视上网比例由2015年至2019年逐年
# 上升，之后有所下降，2020年年底又上升；台式电脑整体上逐年下降；笔记本电脑上网所
# 占比例最低，此外呈逐
# 年下降趋势，平板电脑分别在2017年之前，2018年年底，2020年年底之后这几个时间节点之间
# 下降，上升，下降，上升，总体上下起伏；

#########################################################
# 2.3 

# 读入数据集：“(3)2008-2022年网民结构.csv”
net_structure <- read.csv('(3)2008-2022年网民结构.csv')

# (1)	与“(1)2002-2022年网民数量.csv”进行合并；
num_sructure <- full_join(netizens_num,structure,by = c('时间' = '时间'))

# (2)	编写函数计算出城镇网民数量、农村网民数量、男性网民数量、女性网民数量、各年龄层网民数量、
# 各学历网民数量（可以编写函数通过apply族函数进行批量处理，也可以直接编写循环函数直接一次性
# 得到所有结果）；
# 数据类型转化函数
trans_num <- function(percentage){
  percentage <- gsub("%","",percentage)
  percentage <- as.numeric(percentage)
  percentage <- percentage/100
  return(percentage)
}
# 计算各项目人数的函数
num_calculate <- function(percentage){
  num <- num_access$网民数量.万人.*percentage
  return(num)
}


# (3)	进一步计算网民性别比（以女性网民为100，男性对女性的比例）、城乡比（以农村网民为100，城镇对农村的比例）、年龄比（以19岁以下网民为100，其他年龄层对19岁以下的比例）、学历比（以初中及以下网民为100，其他学历对初中及以下的比例）；

# (4)	根据城镇和农村网民数量以及城乡比绘制柱状图和折线图（类似下图所示），最后说明城乡网民的变化。（bonus：主题设置、颜色设置、细节处理基本跟下图完全一样）





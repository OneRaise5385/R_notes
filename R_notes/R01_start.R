# 包的加载
library()

# 更新包
update.packages()

# 移除包
remove.packages()

# 获取帮助
help(package = 'ggplot2')
?help

# 获取当前工作目录
getwd()

# 设置工作目录，使用的时斜杠/
setwd('C:/Users/OneRaise/Documents')

# 获取文件路径
file.choose()

# 加载R文件
load(file.choose())

# 加载某个包内的数据集
data("AirPassengers")

# 列出当前环境中的对象
ls()

# 移除某一个对象
rm(v)

# 移除所有对象
rm(list = ls())




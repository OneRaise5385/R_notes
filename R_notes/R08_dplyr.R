# dplyr
library(dplyr)
head(ToothGrowth)
str(ToothGrowth)

# 新增变量和变量重新赋值
toothgrowth2 <- mutate(ToothGrowth,
                       len = len ^ 2,  # 更改变量/赋值
                       nv = 1:nrow(ToothGrowth),  # 新增变量
                       nv2 = ifelse(nv > median(nv),'H','L'))  # 新增变量
head(toothgrowth2,n = 5)

# 筛选行（对样本进行处理）
toothgrowth3 <- filter(toothgrowth2,
                       nv %in% 1:50,
                       nv2 == 'H')

# 筛选列（对变量进行处理）
toothgrowth4 <- select(toothgrowth3,
                       c(2,4))

# 分组计算
summarise(ToothGrowth,len_max = max(len),len_min = min(len))
summarise(group_by(ToothGrowth,supp),len_max = max(len))
summarise(group_by(ToothGrowth,dose),len_max = max(len))
summarise(group_by(ToothGrowth,dose,supp),len_max = max(len))

# 管道操作符
library(magrittr)
ToothGrowth %>%
  mutate(nv = 1:nrow(ToothGrowth)) %>%
  filter(nv %in% 1:50) %>%
  select(1:2) %>%
  group_by(supp) %>%
  summarise(len_max = max(len)) %>%
  as.data.frame()

# 连接/合并数据框
df1 <- data.frame(c1 = 2:5,
                  c2 = LETTERS[2:5])
df2 <- data.frame(c3 = LETTERS[c(2:3,20:23)],
                  c4 = sample(1:100,size = 6))

# 左连接
left_join(df1,df2,by = c('c2' = 'c3'))  # by是合并条件
# 右连接
right_join(df1,df2,by = c('c2' = 'c3'))
# 全连接
full_join(df1,df2,by = c('c2' = 'c3'))
# 内连接
inner_join(df1,df2,by = c('c2' = 'c3'))

#---------------
# 列的分裂与合并
library(tidyr)

# 分裂
df3 <- data.frame(c5 = paste(letters[1:3],1:3,sep = '-'),
                  c6 = paste(letters[1:3],1:3,sep = '.'),
                  c4 = c('B','B','B'),
                  c3 = c('H',"M",'L'))
df4 <- df3 %>%  # remove表示是否保留被分割的列
  separate(col = c5,sep = '-',into = c('c7','c8'),remove = F) %>%
  separate(col = c6,sep = '\\.',into = c('c9','c10'),remove = T)
# '.'表示在r语言中表示的是任意字符，需要用转义符\\.来表示点号原本的意思


# 合并
df5 <- df4 %>%
  unite(col = 'c11',c('c7','c8'),sep = '_',remove = F) %>%
  unite(col = 'c12',c('c9','c10'),sep = '@',remove = F) %>%
  unite(col = 'c13',c('c4','c3'),sep = '$',remove = F)


#--------------------
# 长宽数据转换
set.seed(42)
df6 <- data.frame(time = rep(2011:2013,each = 3),
                  area = rep(letters[1:3],times = 3),
                  pop = sample(100:1000,9),
                  den = round(rnorm(9,mean = 3,sd = 0.1),2),
                  mj = sample(8:12,9,replace = T)
                  )
# 宽数据转长数据
df7 <- df6 %>%  
  pivot_longer(col = 3:5,
               names_to = 'varb',
               values_to = 'value'
               )

# 长数据转宽数据
df8 <- df7 %>%
  pivot_wider(names_from = c(area,varb),
              values_from = value)










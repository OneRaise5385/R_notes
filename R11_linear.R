# 普通线性回归
head(mtcars)
str(mtcars)

# 了解变量，并且把变量处理好
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am)

# 建模



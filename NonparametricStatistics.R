######### 1.1 R 基本操作和概念
x <- TRUE
a <- 2
pi
mode(x)
mode(a)
mode(pi)
length(x)
length(a)
exp(2)
factor(x)
factor(a)
choose(10,3)
# 两种阶乘的算法，注意，使用gamma()阶乘计算的是n-1阶
gamma(3)
gamma(4)
factorial(3)
factorial(4)
sin(pi/2)

######### 1.2 向量的生成和基本操作
# 向量生成
vector_1 <- c(1,2,3,4)
vector_2 <- seq(1,9,2)
vector_3 <- rep(1:5,3)
mode(vector_1)
mode(vector_2)
mode(vector_3)

# 选取向量元素
vector_3[6]
vector_3[length(vector_3)]
vector_3[c(5,6)]

# 在向量内插入
c(vector_3[1:2],9,vector_3[3:length(vector_3)])
c(vector_3[1:2],c(9,9,9),vector_3[3:length(vector_3)])

# 向量的合并(数值型和字符型的向量合并时，合并后的向量默认为字符型)
vector_4 <- c(vector_1,vector_2)
vector_5 <- c(vector_1,NA)

# 删除数据
vector_2[-2]
vector_2[-c(2,3)]

# 替换数据
vector_1[1] <- 9
vector_1[c(1,2,3)] <- 8
vector_1[c(1,2,3)] <- c(9,9,9)

# 正宏汇负一楼什么淘小胖，东西很便宜

# 向量逆向排列
rev(vector_1)

# 排序
sort(vector_4)

# 去掉向量中的缺失值
na.omit(vector_5)

# 向量的运算
5 * vector_1
10 + vector_
# 向量之间相加只保留元素少的向量的位数
vector_1 + vector_2

# 统计函数对向量的运算
min(vector_1)
max(vector_1)
mean(vector_1)
median(vector_1)  # 中位数
var(vector_1)  # 方差
sd(vector_1)  # 标准差
rank(vector_1)

# 向量的逻辑运算，比较短的向量的元素之间的大小
vector_1 < vector_2
vector_1 != vector_2
vector_1 == vector_2

######### 1.3 高级数据结构
# 生成矩阵
vector_6 <- c(1,2,3,4,5,6)
matrix_1 <- matrix(vector_6,2,3)  # 默认是不按行排列
matrix_2 <- matrix(vector_6,2,3,byrow = F)
matrix_3 <- matrix(vector_6,2,3,byrow = T)

matrix(vector_6,2,2)  # 先从向量中取够元素，再排列
matrix(vector_6,2,2,byrow = T)

# 给矩阵的行或列命名
dimnames(matrix_3) <- list(c('a','b'),c('d','e','f'))












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
rank(c(9,2,4))  # 排序，输出原来元素对应的次序

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

# 矩阵元素的选取
matrix_3[2,3]
matrix_3[2,]
matrix_3[,1]

# 矩阵的运算
3 * matrix_3  # 数乘
matrix_1 + matrix_3  # 相加
matrix_1 %*% t(matrix_3)  # 矩阵相乘，保证同型，注意符号
t(matrix_3)  # 求转置
matrix_2 <- matrix(c(1,2,3,4),2,2,byrow = T)
matrix_4 <- matrix(c(4,5,6,7),2,2)
solve(matrix_2)  # 求逆矩阵
solve(matrix_2,matrix_4)  # 矩阵求解matrix_2 %*% X = matrix_4
det(matrix_2)  # 求行列式
matrix_5 <- diag(c(1,1,1,1))  # 单位阵
eigen(matrix_2)  # 求特征值
# combin（）：https://blog.csdn.net/xiaoxiao_ziteng/article/details/114944003
combn(a,2)  # a中任意两个数的组合
combn(a,3)

# apply()函数的应用
apply(matrix_2,1,sum)  # 第二个参数，1代表行，2代表列

# 列合并
cbind(matrix_1,matrix_2)  # 矩阵合并
cbind(matrix_1,vector_1)  # 矩阵向量合并

# 行合并
rbind(matrix_1,matrix_3)
rbind(matrix_1,vector_1)

# 数组（多维矩阵）


# 数据框
df_1 <- data.frame(matrix_1)
df_2 <- data.frame(matrix_1,matrix_2)

name <- c('Jack','Mike','Jane','Alen')
age <- c('20','21','19','18')
id <- c('001','002','003','004')
df_student <- data.frame(id,name,age)
attach(df_student)  # 能直接使用df_student中的特征，例如age

# 列表（将不同类型的数据进行打包）
list(matrix_1,df_student)


######## 1.4 数据处理
# 保存数据
write.table(df_student,'data/df_student.txt',row.names = T,col.names = T)

# 读入数据
df_student2 <- read.table('data/df_student.txt')

# 数据转换
as.array()  # 转为数组
as.factor() # 转为数据框
as.character()  # 转为字符
as.numeric()  # 转为数值
as.data.frame()  # 转为数据框

######## 1.5 R编程
# 判断语句
i <- 0
if (a > i) {i + 1} else {print(i)}

# 循环语句
for (i in 1:4){
  print(i**2)
}

while (i < 4){
  print(i**2)
  i = i + 1
}

# 函数的编写和调用
f1 = function(x){
  x ** 2
}
f1(3)

f2 = function(x,y){
  return(x ** 2 + y);x + y
}
f2(2,9)

f3 <- function(x){
  x ** 2 + sin(x)
}
f3(1)

######### 1.6 统计计算
# 抽样
s1 <- sample(100,10)
s2 <- sample(100,10,replace = T)
unique(s2)  # x中重复的数据只显示一次

# 统计分布
# 正态分布:norm(x,mean,sd)
dnorm(c(0,1,2,3),0,1)  # 密度函数求值
pnorm(c(0.1,0.2,0.5,0.9),0,1)  # 分布函数求值
qnorm(c(0.1,0.2,0.5,0.9),0,1)  # 分位数求值
rnorm(10,0,1)  # 生成正态随机数

# 二项分布

# 超几何分布









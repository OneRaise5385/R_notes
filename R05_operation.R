# 数据的运算

# 基本运算
1 + 2
3 - 1
3 * 4
9 / 3

c(1:4) + c(2:5)  # 向量的对应位置的元素相加减
c(5:9) * c(1:5)  # 向量对应位置相乘

4 ^ 3
exp(1)
log(x = 25,base = 5)
sqrt(4)
abs(-5.6)
sign(-3.2)  # 符号函数，负数返回-1，整数返回1，零返回0
round(3.1415926,2)  # 保留几位小数
signif(3.1415926,2)  # 保留有效位数
ceiling(3.2)  # 向上取整
floor(3.2)  # 向下取整

# 逻辑运算
2 == 3
2 != 3
2 > 3 

2 %in% 2:5

(2 > 3) & (2 > 1)  # 与
(2 > 3) | (2 > 1)  # 或
!(2 > 3)           # 非


# 向量相关的运算
v2 <- c(3,2,7,4,6,8,8,11,9,21)

# 最大值
max(v2)
# 累积最大值
cummax(v2)
# 最小值
min(v2)
# 累积最小值
cummin(v2)

# 求和
sum(v2)
# 累积求和
cumsum(v2)
# 乘积
prod(v2)
# 累积乘积
cumprod(v2)

# 均值
mean(v2)
# 中位数
median(v2)
# 标准差
sd(v2)
# 方差
var(v2)

# 向量逆转
rev(v2)
# 向量重排
sort(v2)

# 向量元素频数统计
table(v2)
# 向量的取值水平(把向量中重复出现的元素只输出一次返回)
unique(v2)

# 索引函数
which(v2==8)  # 返回的是元素的位置
which.max(v2)  # 返回最大值第一次出现的位置
which.min(v2)  # 返回最小值第一次出现的位置

# 交集
intersect(1:5,4:8)
# 差集
setdiff(1:5,4:8)  # 前面中出现而后面没有出现的元素
# 补集
union(1:5,4:8)  # 返回值中没有重复的元素

#----------------------
# 数据框和矩阵相关的函数
dfs <- data.frame(
  a = 1:5,
  b = 3:7,
  c = letters[1:5]
)

# 行列合并
df1 <- dfs[1:3,]
df2 <- dfs[3:5,]
# 行合并
rbind(df1,df2)
# 列合并
cbind(df1,df2)

# 列运算
colMeans(dfs[,1:2])  # 求均值
colSums(dfs[,1:2])  # 求和
# 行运算
rowMeans(dfs[,1:2])
rowSums(dfs[,1:2])

# apply(x,margin,function)
apply(dfs[,1:2],2,sd)  # 2对应列
apply(dfs[,1:2],1,sd)  # 1对应行

# 对象结构信息
str(dfs)  # 
summary(dfs)  # 返回dfs的描述性统计的信息
View(dfs)  # 查看dfs
head(dfs,n = 2)  # 查看dfs前两行的信息
tail(dfs,n = 2)  # 返回dfs的末尾两行的信息

# 矩阵运算
m3 <- matrix(
  c(5,7,3,4),
  ncol = 2,
  byrow = T
)
m4 <- matrix(
  c(5,7,3,4,8,9),
  ncol = 3,
  byrow = T
)

# 矩阵的转置
t(m3)
# 矩阵相乘
m3 %*% m4
# 矩阵的逆矩阵
solve(m3)  # m3 %*% x = E,返回x
solve(m3,m4)  # m3 %*% x = m4 ，返回x
# 矩阵的行列式的值
det(m3)

#-------------------------------
# 字符函数与分布相关函数

# 连接成字符向量
paste(1:5,collapse = '+')
paste(letters[1:5],collapse = '-')
paste(1:5,letters[1:8],sep = '~')
paste0(1:5,letters[1:8])
paste(1:5,letters[1:8])

# 字符长度
nchar(month.name)
# 全部转大写
toupper(month.name)
# 全部转小写
tolower(month.name)
# 含有某个字符的元素的索引
grep('Ju',month.name)
# 替换字符
gsub('e','000',month.name)

# 随机分布函数
set.seed(24)  # 随机种子，在相同随机种子的情况下，随机抽样的结果是相同的
sample(1:2,12,replace = T)  # 随机抽样sample(样本集，抽样次数，是否放回)
rnorm(10,mean = 1,sd = 2)  # 生成随机数
pnorm(1,mean = 1,sd = 2)  # 累积概率
qnorm(0.5,mean = 1,sd = 2)  # 分位数
dnorm(1,mean =1,sd = 2)  # 概率密度

# 图形绘制
plot(x = seq(-5,7,length = 1000),
     y = dnorm(seq(-5,7,length = 1000),
               mean = 1,
               sd = 2),
     type = 'l',
     ylim = c(0,0.25)
     )
abline(h = 0,
       v = 1)


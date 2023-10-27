# 数据结构

# 向量----------
# 常量
pi
letters
LETTERS
month.name
month.abb

v1 <- 1:5
v2 <- c(3,2,5,8,6)

# 重复
v3 <- rep(v2,times = 2)  # 将v2重复两次
v4 <- rep(v2,each = 2)  # 将v2中的元素重复两次
v5 <- rep(v2,times = 2,each = 2)

# seq函数
v6 <- seq(from = 2,to = 9)
v7 <- seq(from = 2,to = 9,by = 3)
v8 <- seq(from = 2,to = 9,length.out = 3)
v9 <- seq(from = 2,to = 9,length.out = 4)

# 字符型的向量
w1 <- c('aic','bic','cp')

# 逻辑型向量
w2 <- c(T,F,T,T,F)

# 向量元素的属性
# 向量元素的名称
names(v2)
names(v2) <- w1  # 向量元素的命名

# 向量的长度
length(v2)

# 向量的索引
v2[1]  # 位置索引
v2[c(1,3,5)]  # 提取多个元素
v2[-c(1,4)]  # 将1和4位置的元素排除掉
v2[c('aic','cp')]  # 名称索引
v2[v2%%2==1]  # 条件索引

# 矩阵-----------
m1 <- matrix(1:6,
             nrow = 2,
             byrow = T,
             dimnames = list(c('r1','r2'),c('c1','c2','c3'))
             )
m2 <- matrix(1:6,
             nrow = 2,
             byrow = F,
             dimnames = list(c('r1','r2'),c('c1','c2','c3'))
             )
m3 <- matrix(c((1:6),letters[1:6]),
             nrow = 3,
             byrow = T,
             dimnames = list(c('r1','r2','r3'),c('c1','c2','c3','c4'))
             )

# 行列名称
dimnames(m2)
colnames(m2)
rownames(m2)

# 维度信息
dim(m3)
ncol(m3)
nrow(m3)

# 矩阵索引
m3[1,2]
m3[2,]
m3[,2]
m3[1:2,1:2]
m3[c(1,3),c(1,3)]
m3[c('r1','r2'),c('c1','c2')]

# 转换成向量
as.vector(m1)


# 列表-----------

# 列表的构造
l1 <- list(com1 = v1,
           com2 = m1)
# 列表的名称
names(l1)
# 列表的索引
l1$com1  # 返回的是列表内元素的值
l1[['com1']]
l1[[2]]
l1['com1']  # 以列表形式返回
l1[2]
# 新建成分
l1$com3 <- 3:6
# 释放列表
unlist(l1)

# 数据框-----------

# 构造数据框
df1 <- data.frame(
  c1 = 1:5,
  c2 = LETTERS[1:5]
)
# 维度信息
dim(df1)
ncol(df1)
nrow(df1)

# 行列名称
dimnames(df1)
colnames(df1)
rownames(df1)

# 数据框索引
df1[1:2,2]  # 返回的是向量
df1[,2]  # 返回的是向量
df1[1,]  # 返回的是数据框
df1[,'c1']  # 返回的是向量
df1['1',]  # 返回的是数据框
df1[[2]]  # 返回的是向量
df1['c1']  # 返回的是数据框

# 新建列
df1$c3 <- 2:6

# 生成用于网格搜索的数据框
expand.grid(mtry = 2:5,
            ntree = c(200,500))










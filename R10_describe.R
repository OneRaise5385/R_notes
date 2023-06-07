# ---------------------

# 因子
set.seed(2023)
l3 <- sample(letters[1:3],10,replace = T)
l3
as.factor(l3)
factor(l3)

# 描述性统计分析
set.seed(18)
d3 <- data.frame(
  ind = 1:1000,
  rn = rnorm(1000),
  rn2 = rnorm(1000,mean = 2,sd = 3),
  rt = rt(1000,df = 5),
  rs1 = as.factor(sample(letters[1:3],1000,replace = T)),
  rs2 = as.factor(sample(LETTERS[21:22],1000,replace = T))
)

# 描述性统计分析的结果
summary(d3)
library(skimr)
skim(d3)

# 偏度
e1071::skewness(d3$rn)
# 丰度
e1071::kurtosis(d3$rn2)

# 相关系数
cor(d3$rn,d3$rt)
cor(d3[,2:4])
# 相关性检验
cor.test(d3$rn,d3$rt)
library(psych)
corr.test(d3[,1:3])

# 列联表
table(d3$rs1)
prop.table((table(d3$rs1)))

# --------------------
# 假设检验

# 正态分布的检验
library(rstatix)
head(ToothGrowth)
# 单一变量的检验
shapiro_test(ToothGrowth$len)
# 分组检验
ToothGrowth%>%
  group_by(dose)%>%
  shapiro_test(len)

# 方差齐性的检验
# 两组检验
var.test(len ~ supp,data = ToothGrowth)
# 两组以上的假设
bartlett.test(len ~ dose,data = ToothGrowth)

# 均值检验
#  t检验
t.test(ToothGrowth$len,mu = 18)
t.test(len ~ supp,data = ToothGrowth,var.equal = T,alternative = 'less')





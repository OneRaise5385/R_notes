# ---------------------
# 循环结构
# for循环
for (x in c(-2,3,0,4)){
  print(x)
  y = abs(x)
  z = y^3
  print(z)
  print('---------')
}

# while循环
v1 <- 1:5
i <- 1
while (i <= length(v1)){
  print(i)
  print(sum(v1[1:i]))
  i = i + 1
  print(i)
  print('#####')
}

# 示例
df <- data.frame(
  c1 = 2:5,
  c2 = 4:7,
  c3 = -19:-16
)
for (i in 1:nrow(df)){
  print(sum(df[i,]))
}

j = 1
while (j <= nrow(df)){
  print(sum(df[j,]))
  j = j + 1
}

# next相当与python中的continue
# break相当于python中的break

#---------------------
# 条件结构
a <- 2
if (a > 6){
  print('a > 6')
}else{
  print('a <= 6')
}

if (a > 6){
  print('a > 6')
}else if (a > 3){
  print('a > 3')
}else{
  print('a<=3')
}

s = 46
if (s %% 2 == 0){
  print('s是偶数')
}else{
  print('s是奇数')
}

ifelse(s %% 2 == 0,'偶数','奇数')

# -----------------------
# 函数
f1 <- function(aug1){
  res1 <- 1:aug1
  res2 <- prod(res1)
  return(res2)
}
f1(10)

f2 <- function(aug1,aug2=4){
  res <- aug1 + aug2
  return(res)
}
f2(34)
f2(34,5)

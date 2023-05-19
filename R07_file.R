# ------------------
# csv数据导入
rawdata <- read.table(file.choose(),header = T,sep = ',')
head(rawdata,n = 10)
tail(rawdata,n = 10)
rawdata[1,1]  # 数据的索引
str(rawdata)
read.csv(file.choose())
data.table::fread(file.choose())  # 如果数据集过大时用这个

# csv数据的导出
write.table(rawdata,
            'test1.csv',
            sep = ',',
            row.names = F)
# write.csv(数据集，路径，分隔符，行名)
# data.table::fwrite()

# 读取excel表
library(readxl)
excel_sheets(file.choose())
read_excel(file.choose())

# 批量读取数据
files <- list.files('.\\data\\')
paths <- paste('.\\data\\',files,sep = '')

df <- list()
for (i in 1:length(paths)){
  datai <- read.csv(paths[i])
  datai$object <- str_sub(files[i],start = 1,end = -1)
  df[[i]] <- datai
  print(i)
}
df_all <- bind_rows(df)  # 合并数据集



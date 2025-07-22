# 玻璃类型预测问题：逻辑回归分类模型
## 数据准备
library(utils)
glass <- read.csv("./data/glass.data", header=FALSE) #here::here("data", "glass.data")
names(glass) <- c("id", "RI", "Na", "Mg", "Al", "Si", "K", "Ca", "Ba", "Fe", "Type")
glass <- glass[,-1]
head(glass)
# unique(glass$Type)

# 划分80$\%$的数据为训练集，20$\%$的数据为测试集
set.seed(989898)
glass.smp <- createDataPartition(glass$Type, p=0.8, list=FALSE)
glass.train <- glass[glass.smp,]
glass.test <- glass[-glass.smp,]

# 多元逻辑回归
library(nnet)
glass.model <- multinom(Type ~ ., data=glass.train,maxit=1000)
summary(glass.model)


## 模型评价
# 精确度
train.pred <- predict(glass.model, glass.train, type = "class")
mean(train.pred == glass.train$Type)


# 混淆矩阵
table(predicted=train.pred, actual=glass.train$Type)

## 测试结果精确度
test.pred <- predict(glass.model, glass.test)
mean(test.pred == glass.test$Type)


## 测试结果混淆矩阵
table(predicted=test.pred, actual=glass.test$Type)



